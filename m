Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AG47ELuJNRcMe5xptp+hCPmcuXDY+GKsbcu2UyyW9J+DgXMBno8fazM4CLdVs6HbjqxkrXCORPH+
ARC-Seal: i=1; a=rsa-sha256; t=1520334138; cv=none;
        d=google.com; s=arc-20160816;
        b=F7hPUPfvLrZcfe5Q/HwT6f4kB/P+j2zlLPLi3NptBwpdgw/wYFG+Om2BrfRYcdCta3
         Q8ULzSYielBSwCkToGQdKvCZy2if2AASCt0eS/2VoXO98mtlm/s7rJrF9Br17RoGGt7m
         Qj1Qxo02sURY5OH4OkPaGrfTjnTXI42j3PfEeN+/wCfhFhT3dT1MR2oWL2sS2TLfXXcS
         dv2NOjP5Z3U7tFGJ1ftVXv4khNFKNQKFZodrPKhUpGaWx4aQRzlSBuHhSYWtbhsxAoZe
         CfowN90xfMACXyedIHEbBaZMdlH6HOW+JsCfT7kLsvUslAVO4/bIi9nPM4SlSf0L5qoq
         Szaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sLBlrK+FmYXYC7lJs7A/+xEl1UY5Hn7emzIwu/7KKDM=;
        b=oo9vE3R1kO03YOfavFIkqTWVtgAyFAEBhO5jXFgCoxWpH5bd2jM9rhEVkwx4equ7GM
         nPA1GZYu2XXBr3ydY0FM0j2K9pTnPkPR9CrbDxVPN01S13hvR+M0adu8mj7u24wEjpPX
         y7zuyXkYIcR17KBFi4TKZanu8kY9qxVpkb1aDetuCK3DJ2oH8W8Uyafc9dHzgh2GLfC2
         NusrMYWDYs7UCxE7BrlL+mgf307haOnzkMjuWucMevuqfc0QxuqoCKX6wbv54Ucnb9D2
         +Bb5Ht5A1K6RhacGrRsNn/GrXA5ptUhaGkYhAjxYmdjDqrrf6rf8IOrOlw1ZJnoviVIK
         JnAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 5.9.137.197 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Tue, 6 Mar 2018 12:02:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Seunghun Han <kkamagui@gmail.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] x86: mce: fix kernel panic when check_interval is
 changed
Message-ID: <20180306110207.GC11535@pd.tnic>
References: <20180302202706.9434-1-kkamagui@gmail.com>
 <20180306104320.GB11535@pd.tnic>
 <20180306105748.GA31087@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306105748.GA31087@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1594185889314317546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 02:57:48AM -0800, Greg Kroah-Hartman wrote:
> It would have been nice to add a cc:stable for this, but I'll try to
> watch it and when it hits Linus's tree I'll queue it up there.

I can still add it - it is the top patch and I haven't sent it yet.

/me goes and adds it.

Voila!

:-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
