package omadikh;
import java.util.Date;

public class Feedback {
    private String feedbackId;
    private String customerId;
    private String rating;
    private String comment;
    private Date date;

    // Constructor
    public Feedback(String feedbackId, String customerId, String rating, String comment, Date date) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.rating = rating;
        this.comment = comment;
        this.date = date;
    }

    // Default Constructor
    public Feedback() {}

    // Getters and Setters
    public String getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(String feedbackId) {
        this.feedbackId = feedbackId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackId='" + feedbackId + '\'' +
                ", customerId='" + customerId + '\'' +
                ", rating='" + rating + '\'' +
                ", comment='" + comment + '\'' +
                ", date='" + date + '\'' +
                '}';
    }
}