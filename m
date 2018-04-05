Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522934215; cv=none;
        d=google.com; s=arc-20160816;
        b=gfL0bj++GhARbCk2Q7Sz+AOVfWxuhkuWtg3axEyVUVUzRho0a68d9iK5HTMDMorq3F
         MqAeuWXhD7u9HG0BWpsf5a+1dz7w+NpdzRC5eBrbhA0zD5Zlj1nL4DMPRJc4bkqv//Ga
         fCRRCOS7csbdk2d+0FyMltFGMq4o3ZV+5/7UyBKZgqo6EkgJbkZmfgjr/92ZuTbLFMjJ
         ux9T8KmhFbUGsvwxnrqzvf5Pm8CQL+HJYI4Ke78wD6r0fWUL+Tno63fUyIvwGK91n7LZ
         ZeBy3J8aEbb8dJ6HyJa/pTxEDk8stryeYltDqVreiyLJlbXrmh4AvO5o2koMMBNIag+8
         IzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vISNb30hPzxhTKRNnGsLcZCVvSn/kD15N0x8ZwW75iQ=;
        b=ky6hdnbTwOYlMT+QL3dNxW4mmpdpDd0U8/Z8c/Vd7/l5CzRbZe/98/+MbfyswZIY5C
         vw3IE+dubVcRTo8XeEODF4leHRJOmC5pLDzQxWPMZjuyPS49WVaHYG3ZdG/wZKCzmP58
         CPRG9jDTtFS7R5qghZqzpPpYVMf2+QX/3pIT4m1isoanoJhBUH0x3AXOrxnalnmKZ8SO
         cqSPE4t/ltjbtRhWKh90MGxr0ziuwtIyH9jrEDh3OubjbSXPWqaG453YD0q8pSQhLwIc
         P28JqvVOKxTJybEebsLqgpL8mFe2SATOSkSs31DaqQgInXCvprT8Iq9bG8RPy8+D9PYw
         /2PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+SBP1rLivlmzVa3ce+nLk6LGBPE98+ybVylgaG/CSckOlIDQScDrhMkH+AHBGRinRGHlf8Fg==
Date: Thu, 5 Apr 2018 08:16:53 -0500
From: Rob Herring <robh@kernel.org>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
	mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com, richard.gong@intel.com
Subject: Re: [PATCHv3 1/7] dt-bindings, firmware: add Intel Stratix10 service
 layer binding
Message-ID: <20180405131653.2rso2ta74w663pdx@rob-hp-laptop>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com>
 <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522182014-7338-2-git-send-email-richard.gong@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123727148714212?=
X-GMAIL-MSGID: =?utf-8?q?1596912267500801647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 03:20:08PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 service layer driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> v3: No change
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Please add acks/reviewed-by's when posting new versions.

Rob
