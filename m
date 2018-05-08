Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeEHEF0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:05:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeEHEFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:05:25 -0400
Date: Tue, 08 May 2018 00:05:24 -0400 (EDT)
Message-Id: <20180508.000524.1404835175947355511.davem@davemloft.net>
To: georg@hofmannsweb.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, trivial@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial: fix inconsistent help texts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525694598-1666-1-git-send-email-georg@hofmannsweb.com>
References: <1525694598-1666-1-git-send-email-georg@hofmannsweb.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georg Hofmann <georg@hofmannsweb.com>
Date: Mon,  7 May 2018 14:03:18 +0200

> This patch removes "experimental" from the help text where depends on
> CONFIG_EXPERIMENTAL was already removed.
> 
> Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>

Applied.
