select * from campaign;

-- 1. campaign is most profitable
select Campaign_Type,round(avg(ROI),3) as avg_roi
from campaign
group by Campaign_Type
order by avg_roi desc;

-- 2. best channel per location
select Location, Channel_Used,round(avg(ROI),2) as avg_roi
from campaign
group by Location, Channel_Used
order by Location, avg_roi desc;

-- 3.customer segment analysis
select Customer_Segment,round(avg(ROI),3) as avg_roi,round(avg(Conversion_Rate),4) as avg_conversion
from campaign
group by Customer_Segment
order by avg_roi desc;

-- 4. Top campaigns per type (ranking)
select *
from (
    select Campaign_Type,Company,ROI,rank() over (partition by Campaign_Type order by ROI desc) as rank_campaign
    from campaign
) t
where rank_campaign <= 3;

-- 5. Monthly Trend
select Year, Month_Name,round(avg(ROI),2) as avg_roi
from campaign
group by Year, Month_Name
order by Year, MONTH;

-- 6. Cost vs ROI
select Campaign_Type,round(avg(Acquisition_Cost),2) as avg_cost,round(avg(ROI),3) as avg_roi
from campaign
group by Campaign_Type;

-- 7. Engagement Analysis
select Campaign_Type, round(avg(click_through_rate),4) as avg_ctr,round(avg(Engagement_Score),2) as avg_engagement
from campaign
group by Campaign_Type;

-- 8. High ROI campaigns
select *
from campaign
where ROI > 5
order by ROI desc;

-- 9. High engagement but low ROI
select *
from campaign
where Engagement_Score > 8 and ROI < 2;

-- 10.Cost efficiency
select Campaign_Type,
       round(avg(ROI/Acquisition_Cost),4) as efficiency
from campaign
group by Campaign_Type
order by efficiency desc;

-- 11. Duration impact
select Duration_Days,round(avg(ROI),2) as avg_roi
from campaign
group by Duration_Days
order by Duration_Days;

-- 12. Location performance
select Location,round(avg(ROI),2) as avg_roi
from campaign
group by Location
order by avg_roi desc;

-- 13. 
select Campaign_Type,
       sum(Clicks) as total_clicks,
       sum(Impressions) as total_impressions,
       round(avg(click_through_rate),4) avg_click_through_rate,
       round(sum(Clicks) / sum(Impressions), 4) as click_through_rate,
       round(avg(Conversion_Rate),3) as avg_conversion
from campaign
group by Campaign_Type;