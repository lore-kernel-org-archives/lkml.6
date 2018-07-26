Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE79C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3CD20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3CD20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeGZKWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:22:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57940 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeGZKWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:22:48 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 271949da67c24b93; Thu, 26 Jul 2018 11:06:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     ilia.lin@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end of_device_id array
Date:   Thu, 26 Jul 2018 11:05:05 +0200
Message-ID: <4102618.ESNx517Qjd@aspire.rjw.lan>
In-Reply-To: <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
References: <20180723123429.20040-1-yuehaibing@huawei.com> <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 5:43:35 AM CEST Viresh Kumar wrote:
> On 23-07-18, 20:34, YueHaibing wrote:
> > Make sure of_device_id tables are NULL terminated
> > Found by coccinelle spatch "misc/of_table.cocci"
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index 29389ac..efc9a7a 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
> >  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
> >  	{ .compatible = "qcom,apq8096", },
> >  	{ .compatible = "qcom,msm8996", },
> > +	{}
> >  };
> >  
> >  /*
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied, thanks!


