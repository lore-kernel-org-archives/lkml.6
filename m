Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBHMeY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:34:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752316AbeBHMeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:34:23 -0500
Date: Thu, 8 Feb 2018 20:34:18 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v2 1/2] x86/apic/kexec: Enable legacy irq mode before
 jump to kexec/kdump kernel
Message-ID: <20180208123418.GG30270@localhost.localdomain>
References: <20180125141134.25053-1-bhe@redhat.com>
 <20180125141134.25053-2-bhe@redhat.com>
 <87h8qsd8s8.fsf@xmission.com>
 <877erobt47.fsf@xmission.com>
 <87eflwa8d5.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eflwa8d5.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 at 01:48pm, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:

> > Now that I see that I agree in essence with this patch series.
> > I don't agree with the implemenation details.
> >
> > Can you please split disable_IO_APIC and switch_to_legacy_irq_mode
> > in a single patch.
> 
> Now that I think about it can you call the function not
> switch_to_legacy_irq_mode but restore_boot_irq_mode.  And the
> corresponding x86_io_apic_ops not .disable but .restore.
> 
> That should make the purpose of the code clearer, and help avoid
> mistakes like the one that led to this regression.

Thanks for your comments and great suggestion. Have made change as you
suggested, will post after test passed.

Thanks
Baoquan
