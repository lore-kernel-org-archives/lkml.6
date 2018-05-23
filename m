Return-Path: <kent.overstreet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527113190; cv=none;
        d=google.com; s=arc-20160816;
        b=Wo/hJPVwS6K04nkmSRQYMUTfpncvyuor4Q1gkYu9fzD12WIqwXsB8b1sBU/jXJS/+l
         Y5dAP/UURvVkZ+B+OpiWolQz/r4GSzbUQkNxbU0mtkJtsXy5L0qAkZw6m9p4a6jwmR+9
         sMg0eec2nCoGxVmkgpw+OvCRmGx4fbSI7UF/RD7eTIbJIgnHeq6KGWnuuc9TRgjSRgjj
         +Ld3LrHctZpnwSCt1AAHhMIEWFrUlzXziG16WVlcgaH4VSjUYSi17qp4YAenM5Z2skcN
         YgYl2YV4cfby/s1pvqyKv5o4BfZ+KT0TEZc33GinpV2Hrfd2kf/DV73gxo406/A1zcRE
         PJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=JieYvEHi0e4wPvkyi/UIBM8I3DLZqk1INeI5zMoespA=;
        b=o0ZesgSL6X/Rl7TeAHI/2f1C6YCF3ZmndOxlTMHLaNINDU/DsJh6MKh7lG05bXv0vg
         n20sEFqt0bRxU/prq2Z31kD6qjaCRjvgqOLbuNt8F2Md0skqei09qcssoLlYSrV1DPy5
         RgDeJBcjvkuFoZLmj1fpDDl27C8THOoAs1lx53vAD7xH2G5CpnuDvY2wAUL9ogdIsZ38
         Xu1fEh0CfR0hS2k0ScROxXcxxB245AgrhsTsQ7yJ6bdC3wWl8hsHLpwcTVQUOpBbfiDV
         OokYh15/zK2qbBv/6O10Ax92WV19VhrYk7micjEA8v8cQPRAKjf9pYoVVv2r3YyU1n+g
         /wvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JxNw5s8Q;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JxNw5s8Q;
       spf=pass (google.com: domain of kent.overstreet@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=kent.overstreet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr6lkRS8FhnRwhS/yjSZ2wkcuVfiKvuH2XV8s/yCyizjuJ36sfF1xb9+qqKJg7Cioqy3EH/fA==
Date: Wed, 23 May 2018 18:06:26 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, willy@infradead.org,
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
	selinux@tycho.nsa.gov, dev@openvswitch.org, shli@kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20180523220626.GA23040@kmo-pixel>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-6-kent.overstreet@gmail.com>
 <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb1b28b-12da-5d2b-2308-283af9fe6ae4@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215747530067886?=
X-GMAIL-MSGID: =?utf-8?q?1601294241226666189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 10:24:18AM -0700, Dave Hansen wrote:
> Thanks for the heads-up, Matthew!

Sorry, I was just using scripts/get_maintainers, forgot to check the actual file
for the original author :)

> On 05/22/2018 06:18 PM, Kent Overstreet wrote:
> > All existing users have been converted to generic radix trees
> 
> Well, flex_arrays had a good run, and the new radix trees do look quite
> a bit nicer.
> 
> Feel free to add my ack.

Cool, thanks!
