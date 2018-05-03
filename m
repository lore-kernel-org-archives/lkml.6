Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-2048198-1525329429-2-16074495030828493687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_MED -2.3, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='134.134.136.20', Host='mga02.intel.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: jarkko.sakkinen@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525329428; b=gQF+Xlb6EOOGjVKlnkIhns+SG/tlOcavelPHH74zjXR6FIt2rb
    BMRNSgLSPG7ndpXx3tmEVcFUjMEpofc0Ddo1neOIRPvp66TY4UiKWVMFwAdgFQ3Y
    FyEGN3ypgySiVWru3O4eTVy39DdX3fcezLjfn8FPYmEtOWqA9roSuM9UVcgnFTHb
    I4kStR2ijaCslqHJzaPAf/zYvTf3V6eFH7QKGP7YxFXH3lXLc8kq/1OKhsj/DVRB
    8JjfLI1N4W+vBWp0b17+Mto9yvQsKucd5a3ew9V9XRetTDmkfZ0sEmPSgV6te1/+
    hRAANdMg8o9skamcC9m2pwPqGUVk4hWJvQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1525329428; bh=AMA+b3d2q9kXVrMYBvlQQruuIhmyBSd4n72J29H0/Io=; b=B
    b518lxRibqR1HyXu+arWhC6xuUIHeA3vdeJ25Qjgz+a2Q6Stl72E8etaAtw7KP0J
    098nWlXG0ifQ6y5cOhk50jLHJZE01eneXNe4rL6rlsaO5VND6nen2dFZLUAYFeem
    BlHUSv7tXYtScL2swRL7pAzzmOZFGZR9sg8n2WNxEo2uJS4XOYOehY9tNEIjaDft
    WHIbyTiIYQy7Jn5g2ELYnGSoiENIDOj+KnLidZvpprdRlkz6H95+GmBH6aOXVozm
    xVvUzn01xSFRXWP9wEEswB+fUtOAv4BECYp1Q3yhYBgtmUNrSzlQHVVE8sdv5Yde
    do8tC8JCMUu3PaBH0u2XA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=none smtp.mailfrom=jarkko.sakkinen@linux.intel.com
    smtp.helo=mga02.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
    smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=134.134.136.20 (mga02.intel.com);
    spf=none smtp.mailfrom=jarkko.sakkinen@linux.intel.com
      smtp.helo=mga02.intel.com;
    x-aligned-from=pass (Address match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mga02.intel.com x-ptr-lookup=mga02.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass
      smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfADvaRJdnqWInLR9PFVHb5+tVbSAcu/EzY+R3X2GxwP/asNW1yHvbH98ly/fqLjLLTyCy/vtNoqJoNVRDVPnb3hqkGne0eOWkx367vbHMJU6/l2/gAT1
    6iiLjmGKcJ7A9RsnxdWSGYVwkiwNEhvh4oyTNEgCeXlDPa3F+cDH+dmY8GI8aoyBkIYSssMaOXE6oKIuX/Hr/fxNV/W/q5D9eRU=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=h8G49c9N0KxIvQoKHXEdPQ==:117
    a=h8G49c9N0KxIvQoKHXEdPQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=S5Q-Nb0Y3uzeC1jMc3AA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="52811962"
Date: Thu, 3 May 2018 09:37:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:TPM DEVICE DRIVER" <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/2] fixes for 4.9.96
Message-ID: <20180503063702.GB8702@linux.intel.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
 <20180502205239.GA18099@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502205239.GA18099@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 01:52:39PM -0700, Greg KH wrote:
> On Wed, May 02, 2018 at 05:38:27PM +0300, Jarkko Sakkinen wrote:
> > Decided to add Enric's commit because it is also a bug fix instead
> > of modifying Chris commit.
> 
> Both now applied, thanks.
> 
> greg k-h

Great, I'll send next updates to v4.4.

/Jarkko
