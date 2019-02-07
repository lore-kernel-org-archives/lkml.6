Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C16C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A22721908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dTixeQLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBGNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:54:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MslmhBf6sHBX+lTIZiGv5oF8ktq/q6NsQm5zdWGHpTQ=; b=dTixeQLVu7KVSglvTuT6y6NrB
        rYgagcrHhJjihyiiIkRYAiB55rstLOlgOmT/ytB6+MR4UHv2vN/3TX71ojKEKepM8SM2PM6G+vVRM
        SSi1Bqwl0MYMHTVCwd25Tkg7CkQwvFOQ1e5S8dLp8+Mo2W2npAnkDWxmP00Jx0CmqZmL7ayCGsO5k
        bopYRxg/SUtKwzZ3xaha6RLVrjXS93Tq3k7TytGPy6iLX1acucpccOyvne5HPEFRbNf5FPihb2+bX
        W4dPTweVdsHFZUub8DYpjK75j3A37u79TwYV91pIW4rBFkGuleAtWDlckD64Rgal0bkx4q9IA739A
        2OqF0klUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grk7n-0003OL-U6; Thu, 07 Feb 2019 13:53:55 +0000
Date:   Thu, 7 Feb 2019 05:53:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm: add probe_user_read()
Message-ID: <20190207135355.GU21860@bombadil.infradead.org>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:59:27PM +0000, Christophe Leroy wrote:
>  v3: Moved 'Returns:" comment after description.
>      Explained in the commit log why the function is defined static inline
> 
>  v2: Added "Returns:" comment and removed probe_user_address()

The correct spelling is 'Return:', not 'Returns:':

Return values
~~~~~~~~~~~~

The return value, if any, should be described in a dedicated section
named ``Return``.

