Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELtHmqv6vd27UwpiWo/WghrSKhIdb79TFe4zwSNlLAFg+tgkO7S9XyritvbiqMDIIbNaGEGl
ARC-Seal: i=1; a=rsa-sha256; t=1520442975; cv=none;
        d=google.com; s=arc-20160816;
        b=GU1XXthxi97dW7thhCSxKVKKJTdm4Y04dP0Kjgk6YrMt8skEKiU5U2j+MNzvb0aGCn
         2v8pSvtdU5IyJSU59UdTQ944cMbKeySabESnR+AzawmDKJk6godEy/irRMG5DssOpHhU
         b45Z9a+UoqGEoF3s/+EYuB04TkkPenTgoSMbjH5HtinmJ1asnwVqhHHBW6YcJuTy/z89
         Ao6f6AtASG7uRQmjMa3WLfVGGn+Wmup82iGZMj+Gh/ahQUYInUIbMnjPY6ZDbjLsglJm
         XSOzjr02fr+pSKn2PtOJ/FF7glSzhq5aSmL+wvtK6Qa6nrT2qqR2hhsNa2C9NCP23u0r
         uvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=g05u2ZaS+fHI6cGmzy7Abm1rd1JeBXAdMhlIi/ISQxo=;
        b=xth2pxmQagHz1cWToDfoTZUQi9MlKaxkx4GNia0vcmu/tkDkx2SqpVBruVCv6o0IQf
         KrjQBlLvV3oUfBim/pEmokswPBUZbLMd7M/QJkYPV7i+P/3rsyRi3HVFc+WGT6WgG72n
         zVEHd2RVN3Wd0JVSelP2+OMIxXD7cLCa3c0n93l24i1oNUvfgAU5B6piWsFvSvP2hKFN
         W6crf3zCdXEWIQbr3iW9v987DVQ10hp7vF/rTSk0IrBZbOOw70JpeIOcxxBIrunkbCjQ
         92/7PiL8TH6bRRoRrI85b5v9j9lh26YeB9Pz7VnrdX9RwfTYrQu6Z9y04XK9/U/2/bUo
         nEnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 7 Mar 2018 10:16:14 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Randy Dunlap
 <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: add Co-Developed-by docs
Message-ID: <20180307101614.6722b592@lwn.net>
In-Reply-To: <1520222301-11874-3-git-send-email-me@tobin.cc>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
	<1520222301-11874-3-git-send-email-me@tobin.cc>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068642266552204?=
X-GMAIL-MSGID: =?utf-8?q?1594300014056939296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 14:58:21 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> When Co-Developed-by tag was added, docs were only added to
> Documention/process/5.Posting.rst and were not added to
> Documention/process/submitting-patches.rst
> 
> Add documentation to Documention/process/submitting-patches.rst

Someday we should really pull those documents together into a coherent
whole so we don't have these weird synchronization issues.  But it's much
easier to just apply this, so that's what I've done for now, with Willy's
comma tweak.

I'll leave the checkpatch part to Joe.

Thanks,

jon
