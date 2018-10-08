Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AFBC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846652145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaiKBJnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846652145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIGg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIGg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:36:58 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E7120858;
        Mon,  8 Oct 2018 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539040972;
        bh=qdybYHWnBlSt5nY9WNeRiOlAlu9N2ChVGVXSF3aEXEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaiKBJnhG1LzcMnFfBiG5+lrFydy2Fu5IHByP8CvckLeZmBe1VhrGe9PWJ+toK3kS
         IFA/aT92XtokroIjssEABeCntXRN8VU9LIJ4L1oIpiZagkEWXNgDUMn9d3/loXnlWF
         Ca+0UGs0IgDwzA9f9V/8KwP/MYXJ4kYOilxLkcFU=
Date:   Mon, 8 Oct 2018 16:22:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel-hardening@lists.openwall.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v7 03/28] zinc: introduce minimal cryptography
 library
Message-ID: <20181008232250.GB164708@gmail.com>
References: <20181006025709.4019-1-Jason@zx2c4.com>
 <20181006025709.4019-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006025709.4019-4-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 04:56:44AM +0200, Jason A. Donenfeld wrote:
> Zinc stands for "Zinc Is Neat Crypto" or "Zinc as IN Crypto". It's also
> short, easy to type, and plays nicely with the recent trend of naming
> crypto libraries after elements. The guiding principle is "don't overdo
> it". It's less of a library and more of a directory tree for organizing
> well-curated direct implementations of cryptography primitives.
> 

As I've asked before: please Cc linux-crypto on the whole patch series,
including the cover letter.

- Eric
