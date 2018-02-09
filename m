Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518218500; cv=none;
        d=google.com; s=arc-20160816;
        b=0iQC70apOsp0byvyxqKd151VaGSmyovA9xj77U+VTThETXAmevBfKRRklpCFSKyg/C
         GVbCfwI5svTvUJ3vIRIzgXQAZs8/49EmWqMg9hnFR/2uoUU6gbEurBUM+u3Uh8wE7Uxg
         GHWTpwZfJix7IuhqYoCTdldTbM8vDub4sP4a9BLx08/BgVIq3qx1FCAyL6ZGGmhWsCtW
         WW/PKOoRCWuC9ZupCAICFIqlCI/RxSwLfsElLPeecifintIObKZtF6NqnVGBu4GVljXS
         XM661H26TdiQ1WSuV6j1ln3js0mTI4GEMH77qec9zUTbTleuT6/145QXtTW9ahFsipGP
         WQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uM33nMCp57aLoZiWJcQX/7wXnlyXlPtxGHlo7xDtEqs=;
        b=xVHIOa9s2Wg/Boh6opyxCYJ8K1BR4D22douJMErGM+U7+F8zSlVT1/7h8EQk+opMRz
         S9408br0m5UuWeplgDK8sY3JCs2oYd7B9+fKLThh9eN9feWpAHVgJUydoQsxHJdsDd3g
         pxu9+ZkkbsJb+k8cW/bDieVgLsH4fXWFGULaGEKOd9GbxI1QpEWHr5d9+PuRR5TfZCYK
         xOLKNJz7e86NvrIziwIxU6w+fcMUJKWuSn8/A2eZsM3WrFS1yP0ZKR8R6v4XDgeAhy5h
         +MLH2Nft7CSJ6xJoEJCowL1v/g2FUk8WGz6czVZaMBC8CLofo2A8kfWq7H97fMgtGVGe
         237A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x227LpO7ZQy0CPpQHIjzf2oNBovv4S2D1/V3bxa2enM1eYU13Hab4ebZbzXp7eJXW31txNJdi7w==
Date: Fri, 9 Feb 2018 17:21:38 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, gregkh@linuxfoundation.org,
	matt@codeblueprint.co.uk, sudeep.holla@arm.com,
	hkallweit1@gmail.com, keescook@chromium.org,
	dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
	mark.rutland@arm.com, devicetree@vger.kernel.org,
	Rajan Vaja <rajanv@xilinx.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Message-ID: <20180209232138.dviqnyqxyso6fatp@rob-hp-laptop>
References: <1517957663-16668-1-git-send-email-jollys@xilinx.com>
 <1517957663-16668-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517957663-16668-2-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591694016774801162?=
X-GMAIL-MSGID: =?utf-8?q?1591967482335066903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 02:54:20PM -0800, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

Reviewed-by: Rob Herring <robh@kernel.org>
