Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939853AbeE1QPN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:15:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49769 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933488AbeE1QNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:13:49 -0400
Date: Mon, 28 May 2018 14:52:57 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 231/272] fanotify: Avoid lost events due to ENOMEM
 for unlimited queues
Message-ID: <20180528125257.bppijdymfnsr3yqz@quack2.suse.cz>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100259.797799079@linuxfoundation.org>
 <CAOQ4uxi9emdAqr1JPYgC_T52SjCtpAbac4pSzfZ7vqtmg6nFMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9emdAqr1JPYgC_T52SjCtpAbac4pSzfZ7vqtmg6nFMg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-05-18 15:39:04, Amir Goldstein wrote:
> On Mon, May 28, 2018 at 1:04 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> >
> 
> I do not have objections for applying this patch to stable, but AFAIK
> it is a correctness patch that doesn't fix any bug and it was mainly added
> as a prerequisite to memcg accounting of event allocations, which is not
> yet merged and not destined for stable.
> 
> Jan? do you agree with my statements above?

Yes, you are correct. The problem this patch tries to fix is theoretical in
nature at this point. However my feeling is stable tree has got rather
benevolent in accepting patches in last months and Greg wishes it stays that
way so I'm objecting only to patches I know introduce regressions at this
point.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
