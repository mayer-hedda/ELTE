package election;

import election.candidate.Candidate;

public class Election {
    private int[] voteCounts;

    public Election() {
        voteCounts = new int[Candidate.values().length];
    }

    public void addVote(Candidate candidate) {
        voteCounts[candidate.ordinal()]++;
        // addVotes(candidate, 1);
    }

    public void addVotes(Candidate candidate, int count) {
        voteCounts[candidate.ordinal()] += count;
    }

    public Candidate getWinner() {
        return Candidate.values()[getWinningIdx()];
    }

    public Candidate[] getCandidatesWithMoreVotesThan(int voteCount) {
        Candidate[] result = new Candidate[getCandidateCountWithMoreVotesThan(voteCount)];

        int lastIndex = 0;
        for (int i = 0; i < voteCounts.length; i++) {
            if (voteCounts[i] > voteCount) {
                result[lastIndex++] = Candidate.values()[i];
            }
        }

        return result;
    }

    private int getCandidateCountWithMoreVotesThan(int voteCount) {
        int result = 0;
        for (int i = 0; i < voteCounts.length; i++) {
            if (voteCounts[i] > voteCount) {
                result++;
            }
        }

        return result;
    }

    private int getWinningIdx() {
        int result = 0;
        for (int i = 0; i < voteCounts.length; i++) {
            result = Math.max(voteCounts[i], voteCounts[result]);
        }

        return result;
    }
}
