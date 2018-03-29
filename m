Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeC2BsL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 21:48:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47455 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeC2BsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 21:48:10 -0400
Date: Wed, 28 Mar 2018 18:35:52 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] locking/debug: Restructure the lock debugging menu
Message-ID: <20180329013552.y23c6txym3eognrv@linux-n805>
References: <1522246852-17501-1-git-send-email-longman@redhat.com>
 <1522246852-17501-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1522246852-17501-3-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018, Waiman Long wrote:

>Two config options in the lock debugging menu that are probably the most
>frequently used, as far as I am concerned, is the PROVE_LOCKING and
>LOCK_STAT. From a UI perspective, they should be front and center. So
>these two options are now moved to the top of the lock debugging menu.
>
>The DEBUG_WW_MUTEX_SLOWPATH option is also added to the PROVE_LOCKING
>umbrella.
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
