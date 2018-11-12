Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3596C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996BD22506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpWS4bjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996BD22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeKMF6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:58:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeKMF6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:58:21 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F682245E;
        Mon, 12 Nov 2018 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542053016;
        bh=w5O3anogGACQvP3EfsQWksy1YZ2UDjKhZU67lEevPCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpWS4bjC9q8LD4S9usr7DhrqU0iWKz6J/JtfZ+qmWBcL2i0rTbM0YQH+y2fMwf818
         ZRNL5NhbryZOB186PEx/GAwaisDaL9X1Qr8cojLf2HZIxPrf+My891CPbYyg3meqQW
         LNMO9m35/CLhBC8AlVXd7+32igV8T6tRfViHxkCA=
Date:   Mon, 12 Nov 2018 12:03:36 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181112200336.GB4415@kroah.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com>
 <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
 <20181112023630.GA20359@kroah.com>
 <20181112090828.2573987d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112090828.2573987d@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 09:08:28AM -0700, Jonathan Corbet wrote:
> On Sun, 11 Nov 2018 18:36:30 -0800
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > We should have a checklist.  That's a great idea.  Now to find someone
> > to write it... :)
> 
> Do we think the LPC session might have the right people to create such a
> thing?  If so, I can try to put together a coherent presentation of the
> result.

I do not know who will be there, sorry...
