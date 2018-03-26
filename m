Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeCZFqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 01:46:16 -0400
Received: from imap.thunk.org ([74.207.234.97]:55810 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeCZFqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:46:14 -0400
Date: Mon, 26 Mar 2018 01:46:11 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: "zhenwei.pi" <zhenwei.pi@youruncloud.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4 : fix comments in ext4_swap_extents
Message-ID: <20180326054611.GB15608@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "zhenwei.pi" <zhenwei.pi@youruncloud.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521876504-18326-1-git-send-email-zhenwei.pi@youruncloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521876504-18326-1-git-send-email-zhenwei.pi@youruncloud.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 03:28:24PM +0800, zhenwei.pi wrote:
> "mark_unwritten" in comment and "unwritten" in variable
> argument lists is mismatch.
> 
> Signed-off-by: zhenwei.pi <zhenwei.pi@youruncloud.com>

Applied, thanks.

					- Ted
