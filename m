Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523632503; cv=none;
        d=google.com; s=arc-20160816;
        b=pJWl6Hxv6m3fyiXvy5JsOLSiymODKFpvc1AEF4t/uQamPR/y8urzNFBSFVraeZZlXX
         IZWl/qucvYKIaL/kQUKOG2RGxvrg1iTopUdQhi5anFlPcyXqMHdpSne/u3upoUxXcQPj
         evY7LxFQFHwHwCuuYh5Pbwm3zP8Q0O2yghuaDxH8lWIUIEHqI6YeSKlGwzUUeX1d8AHl
         kPtGG2MTHdQBi5Z3UOE7wJ42RXGbzOItC9ajDR9/c5IYmXDgcV7neMVcrfr1dPwTyesU
         Oj9gttg5v+Cqr066KRLaE9/LyJ2qW2eQtdfsuwcl2OjtZjV+czb9F8EqELkk2UzN0+IN
         twMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KbcpqeHbVav+8PV6S5RLVxNqkQWJMYoVwI/NNI6AzX8=;
        b=xbCEVnDvworxoGqoS/Vm5PNqYKCjXQN0Ast+8vZJA0OznnniwtihL7WdC9XJT6NRYH
         Dvml1pX2oRRI/Lk4fH2uumFSwvtuLzPINPQnczRXcqU2bA9DXOOLtDmQ8PBPZKFfXiO+
         lpJQIvSkn5eRyjnYkdXfmqp1xdLy+TOjTAMQpFVlTe9QhbyNGG+nPy0imlToz33QI8oT
         EiPQ51gRkA1FxMqX2COFVcv69465YCricIe/jWPDI+j6HI4QBLSd47ZS7g1W4pK6IQnL
         vmoEcSJpgNkUuo4bjYIs6oMcOch3H5KLSZLlhhddAnFL1r9NsyF0SOkx7PyS52agoYwd
         FPSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4/ZgaXQGFT/jElkf8jClgsVigJpPTZ5vbw2wKfTKUoVB1/yGgnteYPTRrL2PqlgsQiesgLJ9w==
Date: Fri, 13 Apr 2018 10:15:01 -0500
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, gregkh@linuxfoundation.org,
	matt@codeblueprint.co.uk, sudeep.holla@arm.com,
	hkallweit1@gmail.com, keescook@chromium.org,
	dmitry.torokhov@gmail.com, mturquette@baylibre.com,
	sboyd@codeaurora.org, michal.simek@xilinx.com, mark.rutland@arm.com,
	linux-clk@vger.kernel.org, rajanv@xilinx.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 01/11] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Message-ID: <20180413151501.gvroqgbmwwyfy5pq@rob-hp-laptop>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523389127-14243-2-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389328219344129?=
X-GMAIL-MSGID: =?utf-8?q?1597644476009915366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:38:37PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

Please add acks/reviewed-by's when posting new versions.

Rob
