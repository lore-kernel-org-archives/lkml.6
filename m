Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeFEOVo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:21:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeFEOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:21:42 -0400
Date: Tue, 05 Jun 2018 10:21:40 -0400 (EDT)
Message-Id: <20180605.102140.1297099218379726802.davem@davemloft.net>
To: ast@kernel.org
Cc: daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, arnd@arndb.de,
        yamada.masahiro@socionext.com
Subject: Re: [PATCH net-next] bpfilter: switch to CC from HOSTCC
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605025341.3965492-1-ast@kernel.org>
References: <20180605025341.3965492-1-ast@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Mon, 4 Jun 2018 19:53:41 -0700

> check that CC can build executables and use that compiler instead of HOSTCC
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks Alexei.
