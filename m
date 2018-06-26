Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C5C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B7926CA5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Bgo4t3uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B7926CA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeFZQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:05:25 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:64078 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbeFZQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:05:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 0A61B40386;
        Tue, 26 Jun 2018 18:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1530029115; x=1531843516; bh=0r9jA7lwYDjE6BllOpLHGN4sZDIPc1e0eFY
        +IXihH4Y=; b=Bgo4t3uGhrw/VcWzdYiO/YMx8VRXWATqc6ru47Si/4F0HTU/IrM
        T5kI68zuo31/NDK3w2pr7wbXyqNEZGINyjepfMZAMAKU25B1GMWJMKrQyJwKnNo5
        FxMm6GwXI5lzxkqDQs0B8yiUzkqGtE9DWk/fFz7UUm8yT2NNoDIR7smzaxGQgCY4
        Ndzcpiixq4IO5Sj4hAhys+RJ9Bit68tAuUoEHZ78cYXXdE3/6z8T3/vvKoEF2jvy
        STtQi+Er6aYp5xnIW6evZ2FFC4kgyTCP1H4JXb+7Nkx5NNE8+cZ3FLMzrn+sko4b
        dQdnL9ItOLQz9uAbNyNDG4j1utj5qPz3Ky2QoUo3lbS+unuWQumbxctpD6rDKZV6
        CxzocRc/pxqy8qrbLWEj4NWBEh1Fdfl6/2fjao6HwhrR7WTsaknHxvBDbjAYysBC
        RS/m0unwYxX1CHqS6VDVSfAnt5CpRGdIdfqOVEKxgXmrTQHvNNLFniSqCGTIAkgJ
        BfV5cYQtJHI33p1eFq1iVYaxd67T/TO1hPFmtuRhHOH/twaNEfqZp2jl0k4KAnr9
        UnbBaG/OlP9QEV8YZEUqWzHKLNZt5KhJOFIO8q4Us7bdxc49u/Fax9Rv8/1PMJio
        /mXhgDxxpQ8Sssail2Lv1KT97HM9TL/HJ1IRrrqfII8vCRhuzhmo4f9c=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qppn1kl9Hh5z; Tue, 26 Jun 2018 18:05:15 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 39C81401A0;
        Tue, 26 Jun 2018 18:05:15 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id D0BB55F;
        Tue, 26 Jun 2018 18:05:14 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: doc: Italian translations
Date:   Tue, 26 Jun 2018 18:05:13 +0200
Message-ID: <7896693.EQ4HzDWJ4J@pcbe13614>
In-Reply-To: <20180626092307.42313405@lwn.net>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it> <20180626092307.42313405@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 June 2018 17:23:07 CEST Jonathan Corbet wrote:
> On Wed,  6 Jun 2018 00:48:57 +0200
>=20
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > here again the doc-guide translated in Italian and the Italian
> > skeleton.
>=20
> I have applied the set, thanks.

thank you

> Non vedo l'ore che tutte quei 'ancora da tradurre' spariscono, per=F2!

Piano piano :)

=2D-=20
=46ederico Vaga
http://www.federicovaga.it/


