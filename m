Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4/nR9P0Vtf19GLvRtkMoK4vhPsLFThTgS4UgYE//mI8keGOl3v+IcPqQOwWpfKhhNR9/wLT
ARC-Seal: i=1; a=rsa-sha256; t=1524068064; cv=none;
        d=google.com; s=arc-20160816;
        b=Z1ffjWGPHUnCaBvHoEpcF39Z/eNHcFO8ZVGPwsS/aNxBlQ6xpWE/nktL38lyQVFUNT
         qx/4e9keHqjU8LvMtntu1m50QaVsbKrx5krzLoKHUb1oFwFtUt+XbqJaoqtKM4/RTyZI
         +DsLY01gBYilA/6DXPvl0GDAUAsHsBTsmPaV+TvTI1PfgZj/ECjq2iBj25r3h9+Gsofj
         OeT8d3rIdIiVN1BxlluFUieDbbrGxq4dObVjqfhY/3bNV2UVaGI0vq6AWpKvU8wei+zy
         PGL+2i9Y1mfVYgq9mqFEhFqcvaRx9PbkAegS+DfYbgmbT+fnmnZO0qhB9PpgEEmn3J23
         3hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=dczWCjBqcg6FA4ZP0pr0cKXIkSqtRJqZcWReN4whSCo=;
        b=FljfFMAxssK0AMEcufg9/bp5+8NNORkh05flC7k7hyRq+LLjy65umwvmrUgAC+ruRX
         6lNqYWi1LSL7UtdW0SUwhErBst1OPtHOuSjAze6rH3sbZoauJhrYhTSHaiqkmWOyeYtD
         sLIoRo5NxTrnUOXNaCTJbkfh+D3K1NACNAjC+6nnpzRHvlNR+oaNa62STHIwxaXwBryJ
         vU8ayDs9NqwrqCRpJW6pfglzYPKxGRfEdkKrUKgqBIed94sW6p5Z1BVfbxHgC3cCxstz
         xAK6vidJ8eNgsLimViLrMZz9jkcDwOJt3tXC9DhQ5bpjDBgNDjo0IT8gliggrg7pELrG
         rNzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Wed, 18 Apr 2018 18:14:17 +0200
From: Borislav Petkov <bp@suse.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Vitezslav Samel <vitezslav@samel.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180418161416.GG4290@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418135330.GA23580@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598101194660285085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 06:53:30AM -0700, Raj, Ashok wrote:
> nothing about the microcode itself comes to mind. I'm wondering if
> this similar to the Arch linux that used late-load during booting
> might be an issue.

How so?

They'd echo 1 > /sys/... very early during boot?

Got an example dmesg or so?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
