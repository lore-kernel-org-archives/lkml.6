Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518565284; cv=none;
        d=google.com; s=arc-20160816;
        b=wt6YmODWVGPxDbVqGyE9E0eZ8IZrPvZ84TFpMrxppnCr7D6euGT/FVBYobHibpPmx5
         xHqDuGzR93QZ8PF4WvG9tEUuZJ2tspxSWPjpSWTAQLOWJzxmZRoCYCXAX0VrzuXtIxA8
         Ez5iJWca8uSZvbc9G+DOSqFinBUP1LbszI5clF2WVhUakjhZytPkYw+Wo3hgIT89liXA
         vUjZSOF/3IQAhxMdKXLo3FQbsmwQWKYhzIyh8VRKIh4wgCmJpoS+nQ2W4jFU9kEhx8+X
         XIYaActXAGhdfWzL/5MX8sccpepWYkbuhD+tBIxoHHmf2iSrkglIYGgUNeyNNYnHRpRq
         1MIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=FhW+Q5WKc1wA0U1OMcu5RXbZB2TGLDyxo+aWVRyI+LE=;
        b=f3j0M07c2dGnchtasIzNfw1F5kC/zzVXdGbr6y71cb2J7tPVRY60XWQ+IZQDkTitrT
         V4OqYfZDZ1CT1XozIEP5kxVyBA1fQgjkRFeJwW1dpyP+AfBv3+Zc4k3gbak5nBdi+eJz
         VbsXy0S3UcMpDYOTOQkEZkVt63AOT+IYt7oN0BsX+/IcOdWfcRznNQq+jnQU2TPvpcnu
         EVfLZydEQ75vX1dMvQKh8Rz1kpf8xBWxHDm3AY/EVhDsLLsJzO3JSiEel/KBXvK0T/yD
         2hLfty8ORJOvU88OWf3E/GOFtUqhFZvCn/29fdboEnU0jwLjNjkBNMevqAyWM20Sb1fs
         lwDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EhkhSOkb;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EhkhSOkb;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x225uT1aC8Km0iEtpDVZHoC7B/B8ufOVeK+OX3PPvJ4OJsr2AeEIAT7/jMgYj20CLk1wKRNlWiQ==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Feb 2018 15:41:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	gnomes@lxorguk.ukuu.org.uk, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, thomas.lendacky@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] x86/retpoline: Add clang support
Message-ID: <20180213234122.GA10961@roeck-us.net>
References: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
 <1518042518.3677.153.camel@infradead.org>
 <20180207233211.GA13991@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207233211.GA13991@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1592331112039151061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi David,

On Wed, Feb 07, 2018 at 03:32:11PM -0800, Guenter Roeck wrote:
[ ... ]
> > 
> > See
> > http://git.infradead.org/users/dwmw2/linux-retpoline.git/commitdiff/82a1f41600

Any chance to see a patch with this change anytime soon ?

Thanks,
Guenter
