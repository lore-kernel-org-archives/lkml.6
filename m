Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeCRPUH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:20:07 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:49445 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeCRPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:20:06 -0400
Date: Sun, 18 Mar 2018 16:12:10 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: pcmcia: cm4000_cs: Replace mdelay with
 usleep_range in set_protocol
Message-ID: <20180318151210.GB3523@nataraja>
References: <1521384597-23195-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521384597-23195-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jia-Ju Bai,

On Sun, Mar 18, 2018 at 10:49:57PM +0800, Jia-Ju Bai wrote:
> This is found by a static analysis tool named DCNS written by myself.

nice catch!

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Acked-by: Harald Welte <laforge@gnumonks.org>

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
