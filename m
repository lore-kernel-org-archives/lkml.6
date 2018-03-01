Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519939105; cv=none;
        d=google.com; s=arc-20160816;
        b=zdAFH7ki6rWVDQEVd/DfJP49KLloPjVWumO/yCjD/qm2WZVIi8xUpFA4lVo98G4rHY
         YPbXbTfFueL2xjudco1//doaatpjNv4M6DvLoTEoVZuRFAtBu9r+ZU/VPtNU+ADGl9nG
         xIfhlBpSkGcg7ks1Ry9URRMHwXVyRWTtP8s0pKvpHv+cSZ4qb+ms0aMi9s7klqwxKxpK
         kqesg+1ia7Ap8q+bKZR7eJQIlAUGZbenlNZC8Lzl7zpabnZASwi9lswSv98XQXLjx1hy
         ICTAIodxDyIOCDST/HAldJq8eeCQkIn5yzcvcvhWyPhQU7aypKHmzKINVVoyBPTL5E3d
         Qpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OIz/QyuWsJ0PQ2vn7y1HpDhENmscL12kow3XMgBBQ2g=;
        b=ckz+9AQKo6I+pn2wfEsMDJ1vK4O4iDa/jCC5hSz2mCKbRSCY9lo75U0qzj6RkzJ7+C
         RcqwoobRqDBUqDxHr53gJPMlXPCBUUmDh73flVIxCkRt31u8JlZgDbURgHZ0FkYa7GMC
         76/9yb2kLHIr+LHkQaYKuoOdUfnCdeRlRWru5WkOMLcaFsB/3b28BTXPCtm9MhCkbDxa
         h0l2o0L9Q1Z9eXxbZnpc3/ae+gN7O9D8spYsRWgDLyi1tNVnIAYyvC4JnRwoFmnWolbV
         426aZzCcgJ4KbP7LSvlrJwaxViNoGSCJPUfGL+ryUqT+3Q7FikQnozkFkfq0l4cbl8vy
         jSsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELtTKoobWQob39tqhWv57y+cJouQuJylxPQKNjWkRNHirBHLE4jvaMLjNsjUurYamlJWV2pBbA==
Date: Thu, 1 Mar 2018 15:18:23 -0600
From: Rob Herring <robh@kernel.org>
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: ard.biesheuvel@linaro.org, mingo@kernel.org, gregkh@linuxfoundation.org,
	matt@codeblueprint.co.uk, sudeep.holla@arm.com,
	hkallweit1@gmail.com, keescook@chromium.org,
	dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
	mark.rutland@arm.com, devicetree@vger.kernel.org, rajanv@xilinx.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Message-ID: <20180301211823.g5dl5xvtbkhofrpb@rob-hp-laptop>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519154467-2896-2-git-send-email-jollys@xilinx.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1593771667352484342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 11:21:04AM -0800, Jolly Shah wrote:
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
