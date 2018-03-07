Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520451560; cv=none;
        d=google.com; s=arc-20160816;
        b=h6sUS/UhNkTHJCUT7s8BLd85c1bsz4uy6wE6X6CKpNU/SCcQTLFyRlYz43UE+bqKZF
         aHHGKXPsBgkP1x5fKPqbNHJKKplgz12rvtw4GHUJk/IvQ08XBgY1CJlUD8AKfRAmXWFL
         rR5XC6xT9PWmZX3+mwFAOeAWefvOJPfMcmlpIZgTbEAz3LQQe6pTxV/PBmWz9ONXOhhP
         jdQPg0HfS/6aZWrEk7g1m4glaDu99upvOLTv0kVNWMw/Om185CRLrqyGXZzKACpNBuWo
         5JDWyP8XgweZwMt1TvHTM9XS+ObCt4PzdwemFjOeYgolf3SlMrWIO3QKKGbIcIFUdDEa
         RfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=qoaRE1p5fUp1RTl5u7eD/Y2G12dXHy1co51wul2BQ9k=;
        b=KuGliSeroZIZvtDrF9Pi+D4dz6kQX6UqoYEEjpnsAVFQZXXT18W3D0tWFyU3FdItW/
         r12Ny7PrKDEYqIm7eNf5kx6848ljm6UMBm3XA+Z33x2pZh+n1aQhV1I+QjKCCVb5t9ZW
         DLzqciiXfqKd/r81BHkLh3n01shS22tUZ+x7/vn4OiC/Z+b8UqqGrYCXkdeq6Wl+NFdj
         SBRXiEbRYwZcXCktO+CUpm+B+aDI5GShTPnRSyzgZmpuiXl01nsreOD7owuTwUNjhUAT
         026qaUd3d9CUmFlT8w9sgfZhM4gjepDuMpMJ9Ha4n6uiojYHoR0ymkZLWR8iJFu2TU9w
         6hXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELuMKYTru82hC8TNwMfT3L5+sTNm5VHGlYO5EiP6ldY287ZciHtq88HPCL3RSXnYrbvkXoKYTQ==
Date: Wed, 7 Mar 2018 13:39:19 -0600
From: Rob Herring <robh@kernel.org>
To: richard.gong@linux.intel.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
	mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv2 1/7] dt-bindings, firmware: add Intel Stratix10 service
 layer binding
Message-ID: <20180307193919.56ogsh32odpk6bul@rob-hp-laptop>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519949975-13548-2-git-send-email-richard.gong@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783306027832989?=
X-GMAIL-MSGID: =?utf-8?q?1594309015460009965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 06:19:29PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a device tree binding for the Intel Stratix10 service layer driver
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: Change to put service layer driver node under the firmware node
>     Change compatible to "intel, stratix10-svc"
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
