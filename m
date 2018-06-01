Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFAIus (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeFAIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:50:44 -0400
Date: Fri, 1 Jun 2018 10:50:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Whitmore <johnfwhitmore@gmail.com>
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, colin.king@canonical.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 4/5] staging: rtl8192e: Add and remove blank lines -
 Coding style
Message-ID: <20180601085021.GA8682@kroah.com>
References: <20180526081019.4738-1-johnfwhitmore@gmail.com>
 <20180526081019.4738-5-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526081019.4738-5-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 09:10:18AM +0100, John Whitmore wrote:
> Coding style requires blank line after definitions and function definition,
> blank lines removed. Correction of some indentation.

Do not change indentation in the same patch you should only be doing
blank line removal or adding in.  This needs to be fixed up.

greg k-h
