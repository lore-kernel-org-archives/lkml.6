Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524849617; cv=none;
        d=google.com; s=arc-20160816;
        b=ckHu/v5NbbGmEY+c2sEaQWKx3DxXQA6N1sEbq9BrV353R5Qldp3Bm2/uYEwohosSHP
         UtQvZloUwHAXgTldorgC+AP3Au0F+nb/dVmDJQjCkejMdmgU6vx4kDTPHM9180WFygdA
         V/oxPggcBPRDr3REy2r7DvZ1Ack1JCSrPTLJkPrVTA2YasT5Cbk6Z64qTygLFCkEAGXg
         EVPK5x2ipJgFhVHqclykdD1Gy+mBMmVPVqo4pYHOQ1CQs5q6vpUWfkC72P6csQlyhAdi
         fy1WKTseMdDQ1+B7Fjwn3tBvmkjpoWonEd/5KSe33MqufpFRzY+MhTpFwhLxDk36kNo3
         seBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=wT3IGgPFlxMn4fkBX1lmul9kGXrgoag9hjDVhT+568w=;
        b=Ay9nSrUI8bHqUwFoEyxFbAxTGILRlFmEfSGdBhm1QHE38L5WIHq4kYy9dPxXvWW9dt
         dyC6dw1sCzwFF0+A204pKZ/KLpaGC2Qk1UycgXfkcvDCTvBcEOj8C0vGdH+3h1AfYpuv
         UNbiGc0jHXtD6kMdmWOhBFnQ25N5el3MjvyXytKeSJ1yCre3v6b/BSUl2VktVe0Mc4fU
         tt0ZwtS/fDUbNuNJRYbyrFFob3XmuwoMXsI3EEF/13mIl/0DSJ9AGlPNabJ6kjnnZKZ9
         BIJSDCvVD/ANHi9fYWPCikeBrPagscGDekSS8mzPfl+DJYmmbma5yDBzajSPxyegn0kT
         SWdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZoH0/EOTKso7WGXIF85IGlamwITWXwKTom3TiAT7KgJZoaYmA4/3/0hD+vOM6/mbETYAdvb4Q==
Date: Fri, 27 Apr 2018 12:20:16 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
	catalin.marinas@arm.com, hch@lst.de, gregkh@linuxfoundation.org,
	joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
	frowand.list@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH 1/6 v3] Docs: dt: add fsl-mc iommu-map device-tree binding
Message-ID: <20180427172016.phpsjiique25impv@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894765369527254?=
X-GMAIL-MSGID: =?utf-8?q?1598920712734918306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:57:01PM +0530, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a generic binding for
> mapping fsl-mc devices to IOMMUs, using iommu-map property.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
