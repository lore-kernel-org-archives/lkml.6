Return-Path: <outreachy-kernel+bncBCFPF2XH6UDBBZETQDKQKGQECK2EIZY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520437733; cv=pass;
        d=google.com; s=arc-20160816;
        b=khT/uAW2TVqGblvBXQ0yIWd00/6/1hg6K1r/sAWQQuIFO3XwI7SlVIBSh/0DWBLLje
         LafdCna4oAYSeM81uuxaqsAfcyzlQkslMyfgO6KaWTFNBr5Wn9gyDmueV8NfNMq2wV+s
         Tc8Cw5u1mMILbuuRw4WwoL4q6v7jBbKuhjl/VniCUMpRffNE+Is0nbx6zNV11of6gcHK
         TrX1gTnyn2TeqfX4tCK4ohWQVxT3qQnVnC8PQVCVPhiP/jvw5I30z3Krlof3N5aBYCS5
         dezQXvFzyJtihf+4JMokywCH3eJSXNNJ+aFshdJ2EKSdLuYuBY2Qpn7UzERB64z7nI42
         8uZg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=W2YWrcSLtglJTrZXuQgJQbCZcOulBOq1TUFOr/doYuk=;
        b=k8X4lvdnIAD1hfyCQZQDYEykGpgwHsZhpCNh58zxjC9s9pvKvYxKsP1mjKsm1xlH4+
         lKmbKoiQLhgwn1cpq3OrvHHQZOTRyb0IuPgQu0YEm6wEWEStB6gdLFus35voIjIMfeHf
         qyQhoIlSth5nE6ndDYL6zxFRXHYOZiSmwH4+PafTZYg7B56YEVrpsFQ7KHFHdmnkFyll
         VFGGb95ggkCBVT0zS6S2CQEq6V/4T4xlKZsKWEalFJJYU791QPruTByUBTeCP0bpe3Sh
         6w8VfIvT3Gtu+1loDYQqYeB+Nk9Xiu8WKwcXWP/Au+eafz31oDW6uWvm3KPdIkXyGOo0
         CkaQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cKop0gCQ;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcfpf2xh6udbbzetqdkqkgqeck2eizy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCFPF2XH6UDBBZETQDKQKGQECK2EIZY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cKop0gCQ;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcfpf2xh6udbbzetqdkqkgqeck2eizy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCFPF2XH6UDBBZETQDKQKGQECK2EIZY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520437733; cv=pass;
        d=google.com; s=arc-20160816;
        b=x8iLFVbXv4ea3KKSZZKHRpZ/pfvdddaXg6EsL6MrsC838/xDEZo2wOC4liqASRWMrq
         e4imMwtC/XMFyYH4niu4I193Vh+/7Rczdty6X9iCM9LFdqucbWvSOp8eKJeLjRy/3qEJ
         ndThOBYS5HJJQ6OSO+imkcQyyi/7QOrFPzRPWftd09afBJjsWezR94N8Y5dOkBLPMtJC
         PRggUn3v7TWspFbtj0eIraiWxM89uDY8/OKCd3XEW0TjB0xp3Df80N7ZG/wM2c+6FE0z
         JXv7jpRsNp2zsZc3gdaObaLRVth4atj8T3Oe1t9zA5+A2VRcK29N8eSI0i/Ae6QCTqws
         tN6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=W2YWrcSLtglJTrZXuQgJQbCZcOulBOq1TUFOr/doYuk=;
        b=KW4c4DxxUVhFEHUCw+RKRCyUcE7NMUqaZ5Ii3ZuuPBJlmLk88T98rPCOaYgTH4oL4l
         q7rNR0siCAfIwmmo2k9QtdoRE07PrTXxb06XY330SSCYa73qcTJ6cGwvR9a1tDd2HYEt
         hPmuK9KMdRamTviOklnOicpibb/ULTRzp3RpaX5J8ScCFsuLopXIWd/LNN0+ggzEu7YM
         hkWfYkPcZijlfoTNh3V0bMwswQwypQEuifD82hE9fZuwjoCEFM52m67YBIp9vv6bBYAm
         UTTfsSznKCiRDlLzA6wg/xr4xsjKjrtL/83xvc3hfOL+fRY5TeTm/TB6DI24IFUZCr8W
         erOg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtkUw/t5HZTK7QYnW0i/VUUUhvTdxl5pgb2bnOlwBN5tBu+9pHRg/NkAYpGnmBo2/3iQwA2fQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520437143; cv=none;
        d=google.com; s=arc-20160816;
        b=pWk8LXzq8ML35ysXjQkMyVnmxN0BlODdR5Y+pyCE07K7TMIUNOnEwjJediMYSEETID
         97Gc+kyDzQJ5e0PeALLQrUob9Q7EHwXvHQOCxrsI0Q8ZAYnvZdfS2ftMRX1I3X8+mdOx
         EcnscwGfzoYAoerUb0EEbkLsQFAm6y0Qe8dz7TfJkHmpkqsF8jV2m78SIjIHx+ebpe+z
         1Ea4IX5Inq4B/EMPIPL2PR1ElpyFsmyHVm5TihY1IiwEqwyRwdQnqxNhTnfl7GE+Hw0u
         ZGL7smUhSDJ39I8IvrAF3s8yOmQtaLIbHWXGiuwlPz1f1rl8oRcx4mt7pF0t6aTigLUm
         BO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=W2YWrcSLtglJTrZXuQgJQbCZcOulBOq1TUFOr/doYuk=;
        b=FIq+W9ZwpAeeCOALlH1Q8kO1WkwgGTS57Q0BDMq15dPZYrHAw0Yn+vYjB/2i592fSZ
         5iud7ASjzwpyhO1vEnaiy/87lC0Tg7FT6FqiSG9DdGYp47QjaYrKG482mLWJWsnb8Udv
         weX6HsyCBpH7TwfANTqRWiwRXDYTM9EPDtZk/cJ3Pnjf8/MkeOog/uyJbeIuV9KPYqeM
         aQOWBKWrIRuC/QeKHM0sVIJYFaHBb94y0M3RDKwwq0Dqrr5tUrxwOCIKpUZUHf+RqIPx
         UJsFaJe9VgJ6PsibAP1t0tdltrdJPLxJwGt+2ScSni/Ce/9afvJUUd2/X5vP/T8x4iNO
         CpZQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Wed, 07 Mar 2018 10:39:01 -0500 (EST)
Message-Id: <20180307.103901.1771176275743006915.davem@davemloft.net>
To: arushisinghal19971997@gmail.com
Cc: jdmason@kudzu.us, jakub.kicinski@netronome.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@netronome.com,
 outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180303161456.GA20194@seema-Inspiron-15-3567>
References: <20180303161456.GA20194@seema-Inspiron-15-3567>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Original-Sender: davem@davemloft.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 184.105.139.130 is neither permitted nor denied by best guess
 record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1594294516424572424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sat, 3 Mar 2018 21:44:56 +0530

> Continue at the bottom of a loop are removed.
> Issue found using drop_continue.cocci Coccinelle script.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
> Changes in v2:
> - Braces is dropped from if with single statement.

Sorry there is no way I am applying this.

Just blindly removing continue statements that some static checker
or compiler warning mentions is completely unacceptable.

Actually _LOOK_ at this code:

>  		if(cards[i].vendor_id) {
>  			for(j=0;j<3;j++)
> -				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j]) {
> +				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j])
>  					release_region(ioaddr, cards[i].total_size);
> -					continue;
> -			  }
>  		}

The extraneous continue statement is the _least_ of the problems here.

This code, if the if() statement triggers, will release the ioaddr
region and then _CONTINUE_ the for(j) loop, and try to access the
registers using the same 'ioaddr' again.

That's actually a _REAL_ bug, and you're making it seem like
the behavior is intentional by editing it like this.

And the bug probably exists because this entire sequence has
misaligned closing curly braces.  It makes it look like
the continue is for the outer loop, which would be fine.

But it's not.  It's for the inner loop, and this causes the "use
ioaddr after releasing it" bug.

Please do not submit patches like this one, it makes for a lot of
wasted auditing and review for people.  The onus is on you to read
and understand the code you are editing before submitting your
changes.

Thank you.
