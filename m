Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755082AbeCSCvO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:51:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6925 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754685AbeCSCvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:51:11 -0400
X-UUID: d1eea8d018a54423b2698b322a85922d-20180319
Message-ID: <1521427861.13211.8.camel@mtkswgap22>
Subject: Re: [PATCH v1 02/19] dt-bindings: cpufreq: mediatek: use - instead
 of _ in examples
From: Sean Wang <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
Date: Mon, 19 Mar 2018 10:51:01 +0800
In-Reply-To: <20180226041336.GJ26947@vireshk-i7>
References: <cover.1519378871.git.sean.wang@mediatek.com>
         <fd1fc4c6760ab8fcbf7518df1cecf3837ab18d2c.1519378871.git.sean.wang@mediatek.com>
         <20180226041336.GJ26947@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Matthias

I'm worried you missed the patch which already got both tags Reviewed-by
from Rob and Acked-by: Viresh and thus I thought it
should be ready for your tree.

For the other patches in the same series, I will have v2 to refine them
according to these suggestions and comments in v1 and let them easy to
review.

Really thanks for your effort!
	
	Sean


On Mon, 2018-02-26 at 09:43 +0530, Viresh Kumar wrote:
> On 23-02-18, 18:16, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > It should be good that no use "_" is in examples. Consequently,
> > those nodes in certain files which have an inappropriate name containing
> > "_" are all being replaced with "-".
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > index d36f07e..38cfbb5 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > @@ -26,7 +26,7 @@ Optional properties:
> >  
> >  Example 1 (MT7623 SoC):
> >  
> > -	cpu_opp_table: opp_table {
> > +	cpu_opp_table: opp-table {
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> >  
> > @@ -86,7 +86,7 @@ Example 1 (MT7623 SoC):
> >  	};
> >  
> >  Example 2 (MT8173 SoC):
> > -	cpu_opp_table_a: opp_table_a {
> > +	cpu_opp_table_a: opp-table-a {
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> >  
> > @@ -131,7 +131,7 @@ Example 2 (MT8173 SoC):
> >  		};
> >  	};
> >  
> > -	cpu_opp_table_b: opp_table_b {
> > +	cpu_opp_table_b: opp-table-b {
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
