Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439E320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439E320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=burcheri.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHaLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:00:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41156 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeHaLAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:00:32 -0400
Received: from localhost ([94.79.149.170]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0Lzkkl-1frpoZ0s0R-014zCX; Fri, 31 Aug 2018 08:54:24 +0200
Message-ID: <1535698162.6624.31.camel@burcheri.de>
Subject: Re: blk-mq crashing on battery mode
From:   Massimo Burcheri <massimo@burcheri.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
In-Reply-To: <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
References: <1534926011.18658.29.camel@burcheri.de>
         <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
         <1535092156.11909.8.camel@burcheri.de>
         <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-43iEQBTRbqeAJEy0+Dhb"
Date:   Fri, 31 Aug 2018 08:49:22 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.24.6 
X-Provags-ID: V03:K1:rmaKKkuIB5hDWLY4x1F02EjXtC8AHMGZ8BsiZLqhfJXkci3/JIB
 tOPsEgPfsG9KYexw/YfZDRTz/agAtQJKxLcna8nX/Zecr2GVx/siE6aDb6qPy2+lr629vLr
 nsj8pZ6T21XqMnk4xFxKhfVaesiFuwqmC03Tqio3NvWIOrSQ4jvaYK/18q0x5Cb9D9rVceD
 N7r7YQY64szF2os8Tx3zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dxIrF4K7AwA=:7GQLwIKkom4DcgWXSdY7cp
 Qd+y0095ayc182X8F1zUUYhM66guakMUdkHjeDhriRDyAyvHmrDS0LlARBYnekv9UcuC+ITI9
 M/21OkD75Qle4rp8f3r6zmVTinMh142pzWFyqa6/+CS5MxOpXuK3zYGtbawRa+RwaTHV79pAz
 3Isr/6T/IYb0bPdaaqPDlQjbZepqaC0sG1b7nHZmv3XWOlLXtYa9vZl7RAaAj1JgUY/KKpujP
 1qHWwKMVlRy0rUjgEeIcbKgiwZskO1l/edRMEuxwQZefxijsJrifz0ceSEG7odnB9zWf6l59K
 IROtqwx7LfAI6fQ3FvGL6L4pWeicKxKMseGYRXa+kGoaHGmwRxl8CT81GcxQX3MFRNl+UNV66
 7ILcWpNy1gUpfT8r956n+7L3ePOH5kxU3vOzdA0AsqCnxo+UA1VSNgNiI5zZiovHORzobIvgC
 CHBpmtE44N1GvVoPaQ2GpTuTcCJBW/+DnvfWsbGTUDLPJh1FHcpyqzfgavBazi03ZxSAl1p14
 4m6JMmH0EFsBQ/l4MPMb4GsSXiqrCeO9DDIiElebzw7wa/pVuxAD9lQ6zSg4/E6+ZqA9wqj8K
 7xSV3qNUBYaFWqkEI8LL4yXBa2uqXwh55o9Vm+L4Y2OcrvvaEEqdp2s3CS0hf45Ruu2JZGiAv
 vMwGk1pV94z/46hA8dlRiYrGlBcVJYzhUyBnf7E7Vt2RUzwPrbXQK676AiaYu4gM9MeA8Elam
 TikdExnHpt7X0kvC9WBULLeWNELE2uTLPK/7f3cOyJXZWicEn8oeSywvwllXtc7HoGrVuEcBl
 ijKoyif
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-43iEQBTRbqeAJEy0+Dhb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-24 at 15:12 +0800, jianchao.wang wrote:
> So this issue should not related with io scheduler.

Hi, I can't localize the specific issue and have changed the subject to blk=
-mq.

> Would you please share the entire dmesg log or backtrace you got on 4.18.=
3 ?

Have you been able to reproduce this? I reproduced the backtrace on a vanil=
la
4.18.3:
https://ibin.co/4E3q5dETqA5T.jpg

Best regards,
Massimo
--=-43iEQBTRbqeAJEy0+Dhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAluI5PIACgkQlQj3p5VS
ZjLWOg/+OoHTqFGVd1DSUkWeie6Z0a3PmgFyFESfIIQDOz1xNIR4j/XPvxDR1gut
BXa+lydeJ062GQI+QZZYfhCIOAh1QvrZ2A6dOabar1zM8cDUzaVuRV49a8CK7QOu
DFN5Nh40G2uYRF8mrd6szurzJlTUm8dRixpTxQk5+pwfB3TZU3H2w/d7MAKIxDPH
FzfUup+qLpXSoxUpz1JXSpeOsTVPPTgOqcTMI+nTnnY/WJAMfRr4mFP3MUOTpsWs
ovQoHveFZK9OiWs2xlr+ybEQ3JHMqPecnD8PvKu5xkPA3tODbUYj/bxt+0swzrio
bEZx4ZMWKhLXWppgRAbsPxFb9lXK7kIDDF3AGf3uorFtdPuiKaTd/oxt91oLagKt
SR3xHG1bvyI0AqCQ1PSF4xlg+U7nRWmrramU63VIuoxGpxxRe2CqQP3wgL72UFOt
YCyGFrfPaCmbIltczhkVZoA+UpY+yB2eoZIbYugVirqiZ3znTmbFYNZn3t8/jyqL
sQBWmtuNIkakhqciF9w4AU385iCUpwkpQxUtXGzgKhyNmfaDV/u6ZcIvqpQi2y6D
6kmFD8pTfDkSWCZblOC/c+e2TV3Xvg2HjzyT6Av0xEhs11vwZV2mzug69lrb++Et
yj1xOwB/LU/q3/OzTGpq4RUDWoy/8qApi7yBryw0JSHreie5NSQ=
=hEIB
-----END PGP SIGNATURE-----

--=-43iEQBTRbqeAJEy0+Dhb--

