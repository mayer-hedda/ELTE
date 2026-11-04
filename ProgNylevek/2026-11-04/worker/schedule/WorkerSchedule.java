package worker.schedule;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.HashSet;
import java.util.ArrayList;

public class WorkerSchedule {
    HashMap<Integer, HashSet<String>> weekToWorkers;

    public WorkerSchedule() {
        weekToWorkers = new HashMap<>();
    }

    public void add(int week, HashSet<String> workers) {
        if (!weekToWorkers.containsKey(week - 1)) {
            weekToWorkers.put(week - 1, new HashSet<>());
        }

        weekToWorkers.get(week - 1).addAll(workers);
    }

    public void add(HashSet<Integer> weeks, ArrayList<String> workers) {
        for (int week : weeks) {
            add(week, workers);
        }
    }

    public boolean isWorkingOnWeek(String worker, int week) {
        HashSet<String> workers = weekToWorkers.get(week - 1);
        if (workers == null) {
            return false;
        }
        return workers.contains(worker);
    }

    public HashSet<Integer> getWorkWeeks(String worker) {
        HashSet<Integer> workWeeks = new HashSet<>();
        for (Entry<Integer, HashSet<String>> entry : weekToWorkers.entrySet()) {
            if (entry.getValue().contains(worker)) {
                workWeeks.add(entry.getKey() + 1);
            }
        }
        return workWeeks;
    }
}
