Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6970C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3923F2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="lIDhjVZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfBULj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:39:29 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:29424 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBULj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:39:29 -0500
Date:   Thu, 21 Feb 2019 11:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1550749167;
        bh=V8CdK1hJhDnC2t3CEX2lsncyukEMG79uK0GkmBTzJwA=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=lIDhjVZXpvH3sNRLkvscWSt58hWmQY2joVdA0v9UrYEXYcynj3+zxhxLxbcN2wKkw
         H0rxDAFZdmVsvJG3AfC5v+SfVdNvTSRTG1TuSfUia5VaEOXtUQzWV7DfM8tLQJ/C+a
         P2tZVwil4IpIUNM62hDD7ab72xcx8hk1XSj3y80M=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Pay Fair project changing to FreeBSD.
Message-ID: <JS948ygFqAe-S8e2JlPeqh-Vrlw4LeS1k4JZQVGoGEzYS75j5dkTIgOz11rnGul-bdAfNlCTZcTZv5F_T9aeLEU1JuIWX8wrNoXYAnU8zA8=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are changing to FreeBSD which we feel is more in line with our philosoph=
y, and it always had a saner view on the HZ timer, which ofcourse is there =
for optimizing inner lopp in highlevel programming, making it close to low-=
level. The 1000HZ timer in Linux shows incompetent understanding of this. A=
lso my findings of a 10ms filter in sched.c. GNU blocks thinking so much he=
re, that it was difficult to get through why a 10MS(!) filter in a 4ghz cpu=
 makes little sense..
GNU is a association with gods, and indeed claims of being gods, have occur=
ed several times on LKML. Strange gods, with 1000hz timers, and 10ms filter=
s. Probably related to Gnu, Moo, and other "divine entities".
Instead we seek to disassociate from the schisms of strange gods, and indee=
d suggest PFY O-S. A Pay Fair economic construct, that these peoples pipe w=
as never about ofcourse.

Peace.
Ywe C=C3=A6rlyn
Youtube: https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q


