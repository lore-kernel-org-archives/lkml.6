Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEMIqM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:46:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60837 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeEMIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:46:11 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c2440: fix spelling mistake: "divsiors" -> "divisors"
Date: Sun, 13 May 2018 10:45:40 +0200
Message-ID: <3819884.ugggRtP9TD@aspire.rjw.lan>
In-Reply-To: <20180502053721.5h6jhicjsjss2ixe@vireshk-i7>
References: <20180430144801.6727-1-colin.king@canonical.com> <20180502053721.5h6jhicjsjss2ixe@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 2, 2018 7:37:21 AM CEST Viresh Kumar wrote:
> On 30-04-18, 15:48, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Trivial fix to spelling mistake in s3c_freq_dbg debug message text.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/cpufreq/s3c2440-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
> > index d0d75b65ddd6..d2f67b7a20dd 100644
> > --- a/drivers/cpufreq/s3c2440-cpufreq.c
> > +++ b/drivers/cpufreq/s3c2440-cpufreq.c
> > @@ -143,7 +143,7 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
> >  {
> >  	unsigned long clkdiv, camdiv;
> >  
> > -	s3c_freq_dbg("%s: divsiors: h=%d, p=%d\n", __func__,
> > +	s3c_freq_dbg("%s: divisors: h=%d, p=%d\n", __func__,
> >  		     cfg->divs.h_divisor, cfg->divs.p_divisor);
> >  
> >  	clkdiv = __raw_readl(S3C2410_CLKDIVN);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
