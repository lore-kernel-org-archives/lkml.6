Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527009274; cv=none;
        d=google.com; s=arc-20160816;
        b=ShptTVi7ZYOGqt9FSoo3MkjzAwQxxOYzXjHnrCrMmc4Jd/Op1xnpy2b6D0Dl+nI+3K
         VK+UlCw/6OgZrbwT18VM/UpDkVgoufpOFs/pCtA1RpSOv/BEsx70zvnkclxdlvX/pNWo
         7CBPfWzVJ6Zd3d3EVTLtH4JRQebrJciG6ZCRjNGbwrQM23hNdH+z6DW52hWtit2l48dI
         50exGwZzKqxeSojntr6+WUY/TsASUG26ckmVskaZ4+oMlFUyAaJF517qoxuVscujWEV2
         wBZke3yo9SLmXe9QTmPsUuaOs6dTmMEWwpjLXoTYALLvb5YxfoVJb1VIw98JE7Lq1mb/
         QSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zte5WZdNAOy0H6jhySaTYxhtAM5Cqzd6MZzOjdfl8s4=;
        b=c+cYJTHchk3ModKQdnmsxp/ISd9cVDjNn0ad9IimnC3/6u4RZ+yrhk242Bnp/NgTs5
         IyM/x4CEceqwPRN74yRp+p2p6HreVKTr5WdWyTaeVXfphHhwLv2IkaVwVQP6sywp61jM
         Gw3UktQI/3NBQuEydxOXEoz0ACGmAlz05exSpwScPGsZ5ZE+wPdc+oeS1Ga6pyScTTrk
         l4anVylavMqLL1b8L0fR3QHspkuv1cEU14Lq0SI+MMa6G6npL3T6bHQMiw5jUpO1zXWF
         F6Wxzaft5+USznwBMsUyDfiuIHeF5YmjDuUDgMkm9F+DI74s9K2RTv/+Q5WSaw2XX7V7
         GfMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZq3F4O2thwsv5h4/7g6qwXatKzW6ajstaYkvWArldClHqO1ElFqVFh38lfuOLJz/7isAFJ/vA==
Date: Tue, 22 May 2018 12:14:32 -0500
From: Rob Herring <robh@kernel.org>
To: Erin Lo <erin.lo@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	srv_heupstream <srv_heupstream@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
	mars.cheng@mediatek.com
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: Add bindings for Mediatek
 MT8183 SoC Platform
Message-ID: <20180522171432.GA20397@rob-hp-laptop>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <1526538126-51497-2-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526538126-51497-2-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600691256916306535?=
X-GMAIL-MSGID: =?utf-8?q?1601185277208266870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 02:22:03PM +0800, Erin Lo wrote:
> This adds dt-binding documentation of cpu for Mediatek MT8183.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
