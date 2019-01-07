Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD758C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81F82070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAGLxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:53:37 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:63641 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfAGLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:53:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,450,1539648000"; 
   d="scan'208";a="84221874"
Date:   Mon, 7 Jan 2019 12:53:25 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <Paul.Durrant@citrix.com>
Subject: Re: [PATCH v4 1/2] xen/blkback: add stack variable 'blkif' in
 connect_ring()
Message-ID: <20190107115325.nlw6irg4jgcjx6t2@mac>
References: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546839359-5478-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:35:58PM +0800, Dongli Zhang wrote:
> As 'be->blkif' is used for many times in connect_ring(), the stack variable
> 'blkif' is added to substitute 'be-blkif'.
> 
> Suggested-by: Paul Durrant <paul.durrant@citrix.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
