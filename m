Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeFDL6R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbeFDL6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:58:15 -0400
Date: Mon, 4 Jun 2018 13:57:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/2] n_tty: Fix stall at n_tty_receive_char_special().
Message-ID: <20180604115752.GB16847@kroah.com>
References: <1527295994-3440-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <ce8d7e0f-d7c0-4eb2-5ed5-f38bdb5a975f@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8d7e0f-d7c0-4eb2-5ed5-f38bdb5a975f@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 07:49:40PM +0900, Tetsuo Handa wrote:
> Greg, Jiri, will you pick up these patches?

Sorry, I missed these last week.  They are still in my queue but have to
wait until after 4.18-rc1 is out.  They are not lost, don't worry...

greg k-h
