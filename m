Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeCRLM0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 07:12:26 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39816 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbeCRLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 07:12:24 -0400
Subject: Re: [RFC 2/4] sh: ecovec24: conditionally register backlight device
To: jacopo mondi <jacopo@jmondi.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-3-dmitry.torokhov@gmail.com>
 <20180316100748.GH16424@w540> <20180316233800.GA32310@dtor-ws>
 <20180317092516.g5p5ybka57abyhex@apu3b>
 <02834805-5053-4BDC-9256-DF1AFFEC8630@physik.fu-berlin.de>
 <20180318105422.GA3323@w540>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <31518d93-a6db-70ee-869f-39d09012402b@physik.fu-berlin.de>
Date: Sun, 18 Mar 2018 20:12:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318105422.GA3323@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 121.85.0.195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Jacopo!

On 03/18/2018 07:54 PM, jacopo mondi wrote:
> Sorry if I was not clear here, it is not anyone's intention to remove any support for any SH board. The media subsystem is working to replace some
> components (the legacy camera drivers) a few SH boards (ecovec included) are the only remaining user of. Nobody is working to remove support for those
> boards.

Ok, I am very relieved to hear that. I have invested a lot of work and
effort into Debian's SuperH port and I therefore hope we can still
keep it for a while.

FWIW, I will send out free ST-40 SuperH development boxes to anyone
who is is willing to work on the SH kernel :-).

> I have access to a few SH boards, if you're planning to collect that informations in some wiki, I'll list myself there.

I'll find the proper wiki to post this information. I need to figure
out what I need to get an account for the kernel.org wiki.

Adrian

- -- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYv+KdYTgKVaVRgAGdCY7N/W1+RMFAlquSYcACgkQdCY7N/W1
+RPkZBAAt2dXvx99JoE/X2O3Gsg+v5w682u/bglBBN+IBtFtlE4ARMBrJnyd9I7L
x/a0pDsEBuU1AIy2I6gcLc84ekd1A42qfsh4pISXKhMfDFFVBsxhbk0wbH7tyAqk
EWI7aQsBUVrrDl4pn0CRy0tirRBBabG6U+AiVYVdrxbNBKVMrQlfwf+Y1Ez7fAsP
3gEet5qNYJsQ0ofzQIXIr6i/sXYPL+rovPIRIBsvuvmmaGGvKmbe8PgFehcX1dbj
uPij8bgvfrEcT85hOi3MoCnBd5o1vEbtvfh5aBK4DIIZaAKMXmhDS0fhgQEYerv2
EaxzPkdMmhbd8N5T/DcIbaCoVPPDDDn/PFK1hSwN/lpL4n7ouQPjjA87qwPLbX7o
vfyoAsohtp1qKtepbp+x5CfjCwqeWu7qzaxjUF3tzAorH+wUUDsOKn2dKGHv7Vlr
LtE+IdO2eJPzZpcmZ0e86bn0YNk7ZtVmDMhdyUfbkI4ZkrO3ANJz4Ed+9vJPzAo7
YKZXI1DHJSd33bpAUtNE1Os9DMLqpuMIYxxGPENhEwcvVo5Ftix8NkviHbQxwLbY
GH36VySCqzkYSt6HUavv5W+N9v4T24pvHx9r+D4f6ACiMT17OtVwS5PMjPcARM5/
Ftp3D9JX8ZRMpktGMuUx18Hhm9wnAwhXK28vFoq6u5TLvVkmnu8=
=2O6i
-----END PGP SIGNATURE-----
