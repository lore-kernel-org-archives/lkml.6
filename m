Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeDKLQL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:16:11 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:47036 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeDKLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:16:09 -0400
X-Google-Smtp-Source: AIpwx48gW/j7AXJJMQmrk4LTTEZhYT2r5FkAFU87GVZckkQJTgiSdNoGbVQWZ90HtTsP2oLeDLfzxw==
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
Date: Wed, 11 Apr 2018 13:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410213434.GC3948@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 23:34, Paul E. McKenney wrote:
> Glad it helps, and I have queued it for the next merge window.  Of course,
> if a further improvement comes to mind, please do not keep it a secret.  ;-)

Yes, there are several changes that could be included:

- SV could be added to the prior operation case as well?  It should be
symmetric

- The *_relaxed() case also applies to void RMW

- smp_store_mb() is missing

- smp_rmb() orders prior reads fully against subsequent RMW because SV
applies between the two parts of the RMW; likewise smp_wmb() orders prior
RMW fully against subsequent writes


I am going submit these changes separately, but before doing that I can show
also my rewrite of the cheat sheet.

The advantage is that, at least to me, it's clearer (and gets rid of
"Self" :)).

The disadvantage is that it's much longer---almost twice the lines, even if
you discount the splitting out of cumulative/propagating to a separate table
(which in turn is because to me it's a different level of black magic).

---------------------
Memory operations are listed in this document as follows:

	R:	Read portion of RMW
	W:	Write portion of RMW
	DR:	Dependent read (address dependency)
	DW:	Dependent write (address, data, or control dependency)
	RMW:	Atomic read-modify-write operation
	SV	Other accesses to the same variable


Memory access operations order other memory operations against themselves as
follows:

                                   Prior Operation   Subsequent Operation
                                   ---------------   ---------------------
                                   R  W  RMW  SV     R  W  DR  DW  RMW  SV
                                   -  -  ---  --     -  -  --  --  ---  --
Store, e.g., WRITE_ONCE()                      Y                         Y
Load, e.g., READ_ONCE()                        Y            Y   Y        Y
Unsuccessful RMW operation                     Y            Y   Y        Y
*_relaxed() or void RMW operation              Y            Y   Y        Y
rcu_dereference()                              Y            Y   Y        Y
Successful *_acquire()                         Y      r  r  r   r    r   Y
Successful *_release()             w  w    w   Y                         Y
smp_store_mb()                     Y  Y    Y   Y      Y  Y   Y   Y   Y   Y
Successful full non-void RMW       Y  Y    Y   Y      Y  Y   Y   Y   Y   Y

Key:	Y:	Memory operation provides ordering
	r:	Cannot move past the read portion of the *_acquire()
	w:	Cannot move past the write portion of the *_release()


Memory barriers order prior memory operations against subsequent memory
operations.  Two operations are ordered if both have non-empty cells in
the following table:

                                   Prior Operation   Subsequent Operation
                                   ---------------   --------------------
                                   R  W  RMW         R  W  DR  DW  RMW
                                   -  -  ---         -  -  --  --  ---
smp_rmb()                          Y      r          Y      Y       Y
smp_wmb()                             Y   Y             Y       Y   w
smp_mb() & synchronize_rcu()       Y  Y   Y          Y  Y   Y   Y   Y
smp_mb__before_atomic()            Y  Y   Y          a  a   a   a   Y
smp_mb__after_atomic()             a  a   Y          Y  Y   Y   Y


Key:	Y:	Barrier provides ordering
	r:	Barrier provides ordering against the read portion of RMW
	w:	Barrier provides ordering against the write portion of RMW
	a:	Barrier provides ordering given intervening RMW atomic operation


Finally the following describes which operations provide cumulative and
propagating fences:

                                     Cumulative         Propagates
                                     ----------         ----------
Store, e.g., WRITE_ONCE()
Load, e.g., READ_ONCE()
Unsuccessful RMW operation
*_relaxed() or void RMW operation
rcu_dereference()
Successful *_acquire()
Successful *_release()                   Y
smp_store_mb()                           Y                  Y
Successful full non-void RMW             Y                  Y
smp_rmb()
smp_wmb()
smp_mb() & synchronize_rcu()             Y                  Y
smp_mb__before_atomic()                  Y                  Y
smp_mb__after_atomic()                   Y                  Y
----------

Perhaps you can see some obvious improvements.  Otherwise I'll send patches
for the above issues.

Thanks,

Paolo
