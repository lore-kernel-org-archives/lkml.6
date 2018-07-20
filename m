Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDFBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3BD20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3BD20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeGTWSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:18:43 -0400
Received: from smtp1-3.goneo.de ([85.220.129.32]:50482 "EHLO smtp1-3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeGTWSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:18:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 6E8C223F38F;
        Fri, 20 Jul 2018 23:28:36 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F5bmlz52GdVK; Fri, 20 Jul 2018 23:28:35 +0200 (CEST)
Received: from [192.168.1.107] (dyndsl-091-248-138-213.ewe-ip-backbone.de [91.248.138.213])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 3A41B23F04B;
        Fri, 20 Jul 2018 23:28:35 +0200 (CEST)
Subject: Re: Sphinx version dependencies?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
 <20180720131206.GM30706@thunk.org>
 <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
 <20180720145235.GA27862@thunk.org>
 <cd31ba58ac24851698e06628ceebce4648345ff6.camel@darmarit.de>
 <20180720164421.GG4800@magnolia>
 <93aa59853a491a5ba3d5c3bcc0c991a1b815a67d.camel@darmarit.de>
 <20180720171020.GI4800@magnolia> <20180720204343.GC27862@thunk.org>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <1c30a215-b67a-1e42-2e7d-078882125094@darmarit.de>
Date:   Fri, 20 Jul 2018 23:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720204343.GC27862@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2018 22:43, Theodore Y. Ts'o wrote:
> So if Documentation/sphinx/requirements.txt is the only thing which is
> guaranteed to work, that's fine.  But it might be good to document
> that somewhere.

Hm, I read it again and I guess this is more ore less what the documentation
will say, see 'Sphinx Install' section. [1]

- distros are fragile
- Documentation/sphinx/requirements.txt is the reference environment

.. even if this needs a virtualenv on specific distros. But what is with
the offline build systems Christoph mentioned? I can't see a solution on
the sometimes contradictory requirements on a *reference env* and the package
reposetorie of a distro.

[1] https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html?#sphinx-install

--Markus--
