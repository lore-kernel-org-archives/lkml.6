Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6886FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CA620868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="siGyQJlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CA620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeK3PVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:21:06 -0500
Received: from ozlabs.org ([203.11.71.1]:39689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeK3PVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:21:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435gwg0TTwz9s7T;
        Fri, 30 Nov 2018 15:13:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543551187;
        bh=Yw/CEdYkBDcjo3piUGdQW78VK7DqtoBNk5m2tHWoug4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=siGyQJlhs+m3rWkB7piIpOqTjpIZ08PDTYdwJwCoOyfzbZfXaiwkk2xD2Fk4MLYW/
         hEUELIX2MtCbHjgOKtJONulfUSf1ZrICNi5seFlpp/AirkYCi+AX3+TfP7Qw3t5wGF
         9MYk52eIGsfMYCDtQjHsy2giuK7OZpmfxbGD8be0LJw36Ui46gl4PzMW36vlNePsko
         TTLV5G796rr+s5PL34QUtUc3MpBZJIc1lDmFDuNrPofLtr1kKFSfIH+lNDjfHyJ3n9
         ZHMYtoABx0Swr6wL7S4PMuytjLzKW0PzTwE1tMcTIfoQqIjt1QWTPhZNwzYaVdwsGG
         g13wrB4Zv8Stw==
Date:   Fri, 30 Nov 2018 15:13:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@codeaurora.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: linux-next: build warning after merge of the qcom tree
Message-ID: <20181130151306.1717c895@canb.auug.org.au>
In-Reply-To: <154350904879.88331.1156146258217230705@swboyd.mtv.corp.google.com>
References: <20181116101059.18ad3fc9@canb.auug.org.au>
        <20181129082540.4ceafca6@canb.auug.org.au>
        <154350904879.88331.1156146258217230705@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/z/WkSQemoU=/nA2hEZ2oFJT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z/WkSQemoU=/nA2hEZ2oFJT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, 29 Nov 2018 08:30:48 -0800 Stephen Boyd <swboyd@chromium.org> wrote:
>
> Andy's email isn't at codeaurora.org anymore. Not sure if that matters
> but he may be missing this.

I have updated my contacts list, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/z/WkSQemoU=/nA2hEZ2oFJT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAuNIACgkQAVBC80lX
0GzS/wf+NhZ10pic2eTqiExF7y9UTdAup2H9W4CaRQydkEuCCaNMIH1EoR4H7WGE
XoRQG//um+fubd79E16RbfbqdgIeKk10S1PjE7zCwOiqf4jPOveJs8qu/VaNodHy
rJMcbp0GN3PrTgc/LBQLrWrlDQzorrEhB+tzfvmpT2xePNdafQjCS09zxdA5RSH1
U8eeBu8U7wqYRAvk6OX9bRTNvhwO0Lit6bCTk5zDzJvD2L9iI6bWGDmO4wx/lv+H
aUzkXAjhQlWbYCrTtFvgtl0ujtOvz3MSVh13zLP9a5Wt1mqmhKKLIgUXbeHXL/1H
qn9mQLs3ubEJqyos09et0d9ug4LhSw==
=3V60
-----END PGP SIGNATURE-----

--Sig_/z/WkSQemoU=/nA2hEZ2oFJT--
