Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DD92086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxd48pUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DD92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeK2DNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbeK2DNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:13:38 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3A32081C;
        Wed, 28 Nov 2018 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543421488;
        bh=spkKxPLHmy5aVkfJl1uN840eIhU2i1pk85g2a0JkH5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jxd48pUm/vnfwZpN0SREW4sD3xkljy/qFKQgYYNKw1mumzjhPyec4pzQT3RwAM/6y
         usWro0oKI/UU9jE6zBItrV0rxw8BUPxSY0yJxm6yBYCa5BIjVbRQi0jWTogsc5zDva
         +urk1S4w1oGs9r+vi/F39YlkzdFcRYJCLbxtJgMU=
Date:   Wed, 28 Nov 2018 11:11:24 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Luiz Capitulino <lcapitulino@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: re-add ple_gap module parameter
Message-ID: <20181128161124.GN131942@sasha-vm>
References: <20181123120214.174457a4@doriath>
 <8049C3CD-E816-4270-A64F-0BB92BD56338@oracle.com>
 <20181123132641.712e2695@doriath>
 <0a2d9427-18e7-408a-d0ae-b8277cad542a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0a2d9427-18e7-408a-d0ae-b8277cad542a@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:57:53PM +0000, Moger, Babu wrote:
>My bad.. Sorry about this. I think this should also go to
>stable@vger.kernel.org

Please actually add the stable tag in the commit message if you intend
for this patch to go in stable.

--
Thanks,
Sasha
