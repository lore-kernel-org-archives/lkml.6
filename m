Return-Path: <linux@dominikbrodowski.net>
X-Google-Smtp-Source: AG47ELs/p5wBiJKsHf5S2LA6KYBZQExpRExqRSjTER3rPjQGM2ACmetYXbxC/pzKNhBLXnhRRzoi
ARC-Seal: i=1; a=rsa-sha256; t=1520446156; cv=none;
        d=google.com; s=arc-20160816;
        b=HIEpVa+LPLfc+XVIFhE1GYCn9OT6p2y/5oKkbJ6NfAZQ4LaXxaAX+eUiMemQDEcQEy
         bdVYiVc7UaoPu7akpWTYYqYDj9NQJEwRNlqOuuxFi3ovCiVUQOZoWfyfv+MFw7Ga2Tai
         BvmTd3KoRKvdOrVxeeMiHOLv7H/gDdaiG3tAuv7k+hkIJ+unuU1arR+D1eiEHNaTItFK
         rloaoUNNKCwEiOicg73VhgJKAIeVhf4UUXKMUj7Vt2AaeH5Vcs5tUn41QCgwA1PkOCWl
         UhI++fGqv2EWt89o1xTgfS96EoF2sW556BtUQs8kKcXS02icHbl4hHVdw+N7nvngL8l/
         yKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VjBMWD8H5YfWnMSKWKJhYURq4q9iGdlQTrXlW5vpxIw=;
        b=UWFiwgtf/ycStxZJeY9m2KZWz7xBiLrJWsvRuSVDx03hxxhYE4xhIHlEC+NcDIh3tA
         GkaW5On4epLWj94bhCwwAy/BJuUfAKahuCTkrjW9K0Hj8+Lsn1E1R4FSBVVC6FwndYaS
         v3MfcdeH6XMsPFZHxiHy2lYwbeoPCU89N/m6BtzCxChiSFuzCFatIQCiH9HUmAxMeoaG
         jjTD5M1eixtkHy3aKUxdjDPBDBVOhDUWcT56OzDqr3jiQbBW8fUWiKHkiWSwpWo33XwR
         OhlgTdgEON59Fc0hcu8iR7fOEjBu2qA3IEo6y9KW/+IOS+/AVrXRtXFwPl+tHMr3yMbY
         BP3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 136.243.71.142 is neither permitted nor denied by best guess record for domain of linux@dominikbrodowski.net) smtp.mailfrom=linux@dominikbrodowski.net
Date: Wed, 7 Mar 2018 19:07:34 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: add Co-Developed-by docs
Message-ID: <20180307180734.GA9004@light.dominikbrodowski.net>
References: <1520222301-11874-1-git-send-email-me@tobin.cc>
 <1520222301-11874-3-git-send-email-me@tobin.cc>
 <20180307101614.6722b592@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307101614.6722b592@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594068642266552204?=
X-GMAIL-MSGID: =?utf-8?q?1594303348454000697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 10:16:14AM -0700, Jonathan Corbet wrote:
> On Mon,  5 Mar 2018 14:58:21 +1100
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > When Co-Developed-by tag was added, docs were only added to
> > Documention/process/5.Posting.rst and were not added to
> > Documention/process/submitting-patches.rst
> > 
> > Add documentation to Documention/process/submitting-patches.rst
> 
> Someday we should really pull those documents together into a coherent
> whole so we don't have these weird synchronization issues.  But it's much
> easier to just apply this, so that's what I've done for now, with Willy's
> comma tweak.

In case you still have my patch to Documentation/process/5.Posting.rst
pending, we'll have a mismatch between Co-developed-by there (which has been
used a number of times in the past), and Co-Developed-by in
submitting-patches.rst and checkpatch and Co-developed-by (which was used
exactly once in Linus' tree). That should be coherent at least...

Thanks,
	Dominik
