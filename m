Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753600AbeBUSjx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:39:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40097 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeBUSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:39:51 -0500
X-Google-Smtp-Source: AH8x224ZICO8j1f6DMkehDvpcl32a22eFSSOBu7OViD6oUzmTVOVOyQaMJUvJ1necTpGNPoo+DgEKA==
Message-ID: <1519238388.55655.43.camel@gmail.com>
Subject: Re: [PATCH net-next] tcp: remove the hardcode in the definition of
 TCPF Macro
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2018 10:39:48 -0800
In-Reply-To: <1519133311-22068-1-git-send-email-laoar.shao@gmail.com>
References: <1519133311-22068-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-20 at 21:28 +0800, Yafang Shao wrote:
> TCPF_ macro depends on the definition of TCP_ macro.
> So it is better to define them with TCP_ marco.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

Seems reasonable, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>
