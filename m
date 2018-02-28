Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934998AbeB1VQh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:16:37 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40826 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933018AbeB1VQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:16:32 -0500
X-Google-Smtp-Source: AH8x2271cCXbF2+w22ZpZ1GMRqMsNkpOTVYZaIPSshKr3GohHCfmR2eEU3c5gGq8jvrSm5lu3X5Wew==
Date: Wed, 28 Feb 2018 14:16:28 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Hern=C3=A1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: monis@mellanox.com, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rxe: Remove unused variable (char
 *rxe_qp_state_name[])
Message-ID: <20180228211628.GG13394@ziepe.ca>
References: <1519769278-20094-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519769278-20094-1-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 07:07:58PM -0300, Hernán Gonzalez wrote:
> Note: This is compile only tested as I have no access to the hw.
> This variable was not used anywhere in the code. Removing it saves 24 bytes.
> 
> add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-24 (-24)
> Function                                     old     new   delta
> rxe_qp_state_name                             24       -     -24
> Total: Before=3348732, After=3348708, chg -0.00%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
>  drivers/infiniband/sw/rxe/rxe_qp.c    | 9 ---------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 --
>  2 files changed, 11 deletions(-)

Applied to for-next, thanks

Jason
