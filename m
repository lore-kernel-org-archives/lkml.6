Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeDLGkI convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:40:08 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56070 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeDLGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:40:07 -0400
From: Richard Weinberger <richard@nod.at>
To: =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: Add HAVE_DEBUG_BUGVERBOSE.
Date: Thu, 12 Apr 2018 08:39:57 +0200
Message-ID: <2043784.jpp9CilIeh@blindfold>
In-Reply-To: <1522963262-14640-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1522963262-14640-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. April 2018, 23:21:02 CEST schrieb Hernán Gonzalez:
> This option restores the DEBUG_BUGVERBOSE functionality as it was
> previous to commit 9a93848fe787 ("x86/debug: Implement __WARN() using
> UD0").
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Applied.

Thanks,
//richard
