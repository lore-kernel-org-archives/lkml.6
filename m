Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522162847; cv=none;
        d=google.com; s=arc-20160816;
        b=X4+MmUhGQBYBCbKQkazXKmvirJPcd+yNG17u7R+k/lvBaB2Gt8xnVEklHs9un9qveT
         /hq98BGQ6kjHYyh3qSr5skozCKLM85Ni+jS4OQLJIX86UVjoNYxg8uYBLgTk1jwF7lHl
         h73XSbfuBygqEBdyGpo+yNIMlETKDnWJQl1mhcd3nHsxlmU02M+KC3Xas2Ep5/I8ieRh
         hxxWgLYACR3RAySaHlmiF7+niT4cmx77FHuYYTdooFKx1rqIBd0iuHwhY5lb0JM2SX3G
         BDCMFCv7weSZmxniArmPMVPi8S7rI0iHI4kYOtDEiqNHrYgUhqwLFYCJqVyFxSTTkiZw
         krgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DJ8QavL55KaNP+wVmTcW1Vh2KdxhSz6CCA5yodniuvY=;
        b=JgRvY8oB5ea9kN05J/7Oq2Tss4XizwS9zgSVjc3BbLD+kjCnFWm2zvJMab7TNxwSvW
         l5bQD3gz6KfW+NvzGr4L7p3o1FrEKqcnVuLG12qMy+xUzpIG0PAQg/piPIRwSAlx6wf6
         I4QXKqIzpDPTMKZcwIQtyCrCrjRyY1Xr407MBbdwuWZHpyh3RC2826zpM8WL2plLnhdI
         1AghdRlxl8eETD7Y8YUJjRQCL5C0LvnlttfnQE9/0xT8Fv0f1g3bbG5/6lu7g6EhW1KP
         79pkZcsRF9++2d+m2IAymcfKpS6YLv6lt688igLyXq/0sgblLaTXC38HNO544HMVhCQn
         FNIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELvesISTajann9Bmsu2+7VcHsMwc2rUm4fJf10O/gKUX22PDTTJpxdvifqqmYfFpukLmIlmfag==
Date: Tue, 27 Mar 2018 10:00:45 -0500
From: Rob Herring <robh@kernel.org>
To: Rajkumar Rampelli <rrajk@nvidia.com>
Cc: mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
	jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com,
	arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org,
	xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de,
	krzk@kernel.org, ard.biesheuvel@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
Message-ID: <20180327150045.biqr5ue5djru2dn7@rob-hp-laptop>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1596103430749305683?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 09:52:49AM -0500, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
> > Supply Device tree binding documentation for the NVIDIA
> > Tegra186 SoC's Tachometer Controller
> > 
> > Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> > ---
> > 
> > V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
> >     Renamed dt property values of clock-names and reset-names to "tachometer"
> >     from "tach"
> 
> Read my prior comments on v1.

Also, I'm trying to make sense of who you Cc'ed on this. There's a ton 
of folks I know that I'm pretty sure don't care about this series. Start 
with get_maintainers.pl and add people you know need to see this series.

Rob
