Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbeC0QmX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbeC0QmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:42:18 -0400
Date: Tue, 27 Mar 2018 09:29:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Kr??m??? <rkrcmar@redhat.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
Message-ID: <20180327162956.ocafdhbbuwtaphi5@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
 <20180326002732.qks4cp7qq2xzysnx@linux-n805>
 <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
 <20180326223232.ifaoc3zyjii4gq2f@linux-n805>
 <CANRm+Cw=x1YVSpX1Zcz=EkLFhojSa_zyTOLEiNX-Di3ENGmCiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANRm+Cw=x1YVSpX1Zcz=EkLFhojSa_zyTOLEiNX-Di3ENGmCiA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Wanpeng Li wrote:

>The host admin can control it by qemu command-line, -cpu ...+kvm-hint-dedicated

So this requires qemu code modification, no?
