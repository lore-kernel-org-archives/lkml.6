Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeE3TXX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:23:23 -0400
Received: from anholt.net ([50.246.234.109]:46672 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932108AbeE3TXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:23:22 -0400
From: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Phil Elwell <phil@raspberrypi.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] mailbox: bcm2835: Fix of_xlate return value
In-Reply-To: <1527330240-6181-1-git-send-email-stefan.wahren@i2se.com>
References: <1527330240-6181-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Wed, 30 May 2018 12:23:20 -0700
Message-ID: <87in75ne1j.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The bcm2835-mailbox returns NULL instead of an error pointer, which could
> result in a NULL ptr dereference in mbox_request_channel. So fix this
> by returning a proper error pointer.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlsO+igACgkQtdYpNtH8
nuhUhA//Xx75OvJvsrIPDIcxa/6+Qco1Az24IsT4dHwNbheL5UUHz1xmwIlWzrJa
S6c+1dTp+hiRUwlLyfskHQUTayucQnMybuF9BoePkUIYa2J4J9MdKnCSDxCZiScx
7M93inyCCdzloKR1WEW/UmgFs24iMFahgLxgZzHk0E2sW5+lx3EeYZYgSmtJQ5DJ
UrYmriK9ZbJJJgFvuU3vXRlX2IW+1jePyw56wjRphDT4Rh/EtKBv7vlpFQzzJSjD
Yp5UfR86wn0BqCIy8Zw0RpAFheN78g0TeQysDGcNaq4Sq+wYLIE16T7ItfgHFHig
azzZ8x/pKwxoYE3yajv9j9NMwBhnw+/GWKH8J+PpbNzF1GWoP4hdo/MdJdyH8irL
naGUZpxSIxEYZJlc8jZo0HsJNo4ptgQzp9jcsWR/Fdb2B/R5jf5KazKZS5+k2FkF
xxd3sxBo6dVvjvdCrDAVgHNzAx5fSKNdsjPumDaIUGiVCAc6UupSc6neD1ExnwRz
dGGZBV07bQV29M8CZrlncNow8umBsCpcZOMDvEPZdKQP2lxQyKIZ4uSlJw8sjamO
pkrzA/abpeeelbH/bJmTcRrFeIXjlRmQZ92duRCwW0tf62MNy2dmIRpF5ZbNMxW0
mkZXnHkVS7CBIzF2J6te1NJPGnNW1V7zxKs0Cbto0KGlAeN772E=
=Nwn/
-----END PGP SIGNATURE-----
--=-=-=--
