Return-Path: <mschiffer@universe-factory.net>
X-Google-Smtp-Source: AG47ELubI+1rsMNeSvEi1hh4OsVPGUNokrt+/Pj1WLnC/qqAjWsfuYiHUws4zDLz22S4MQVo2h68
ARC-Seal: i=1; a=rsa-sha256; t=1520869545; cv=none;
        d=google.com; s=arc-20160816;
        b=R+E3P1qmecMMXGe/Y95Vryokpfk05WG7suxn4D4YdWO5xBxT6tqhD+9issmp28zirJ
         mi502MOxTb/fkUArgisZ3Gx6Bnz/v0DYafkAlCM1AKXdCekQZ0WvpuAp63JsTwbcfN54
         nFxjBKZOkV5YYoyLRF9oQlSaYPF12+n9St31e6B+8TyIG+TCwQz+6n3GMOQHxiKP1TMz
         8hrkPaLdquypMUedoy8MgxAoQYDDi1fhYmu8w4idVy0g/5jzWo7ReLHJNvGPFUiVC6qM
         MLMhqZoUqO25I3bwHWJG7pKu6L9rQaze1cCwn6qULZiUDj42vrd83AutmSi+LtTbKRKA
         1cMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:arc-authentication-results;
        bh=Rrpal6zKCQD7QVJvTdK5Pd/K/chGPSeZ7AKe+qu/r7s=;
        b=du7djGCAGyPBwZQAdsAZX/NsWQA9hroK3om5kefT/+tT7DxfTVMJ0c2q+Ih5Y9IvW5
         ElpYCzl845KAc2WWVuXUZl/Avq8h/EG6KmwczcDvOu/a3d9JcUSKBq/ie0IeOe5Yhwii
         /0sZgH6suaj0LdgYZG4+IhfAwjHvCnPEYRwQS8GDvUIQfoQQT5gAL5kuFvMqg8rFNwMf
         Epq17D3jPEp8ukzZSCMGFFWqyzL7W1garU8gzcQI75CI7BwoVEEaKf8cOO6wlms9+h57
         COMXaI10mN224Ruh7DVT7MIJzC4ZWRjfnSEhhp6hoEAwswgVg4gyjR+bguwIdOL5ePr6
         Duew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mschiffer@universe-factory.net designates 104.238.176.138 as permitted sender) smtp.mailfrom=mschiffer@universe-factory.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mschiffer@universe-factory.net designates 104.238.176.138 as permitted sender) smtp.mailfrom=mschiffer@universe-factory.net
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Sasha Levin <Alexander.Levin@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Matthieu CASTET <matthieu.castet@parrot.com>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd> <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd> <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd> <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
 <20180312152811.GB16944@kroah.com>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <5747831a-b237-aa2c-cb47-9773cd2b5956@universe-factory.net>
Date: Mon, 12 Mar 2018 16:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312152811.GB16944@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2uNZMO2HuCPwY4vnEDfGaYBS3WS5Bapti"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591491593744715241?=
X-GMAIL-MSGID: =?utf-8?q?1594747304450069424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2uNZMO2HuCPwY4vnEDfGaYBS3WS5Bapti
Content-Type: multipart/mixed; boundary="NkO56V4fbhZ7k7BjSwKNfWAU5FfuMElfM";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Sasha Levin <Alexander.Levin@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Matthieu CASTET <matthieu.castet@parrot.com>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Message-ID: <5747831a-b237-aa2c-cb47-9773cd2b5956@universe-factory.net>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd> <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd> <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd> <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
 <20180312152811.GB16944@kroah.com>
In-Reply-To: <20180312152811.GB16944@kroah.com>

--NkO56V4fbhZ7k7BjSwKNfWAU5FfuMElfM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/12/2018 04:28 PM, Greg KH wrote:
> On Mon, Mar 12, 2018 at 04:00:01PM +0100, Matthias Schiffer wrote:
>> On 02/06/2018 09:44 PM, Jacek Anaszewski wrote:
>>> On 02/06/2018 03:02 AM, Sasha Levin wrote:
>>>> On Sun, Feb 04, 2018 at 06:17:36PM +0100, Pavel Machek wrote:
>>>>>
>>>>>>>>>> *** if brightness=3D0, led off
>>>>>>>>>> *** else apply brightness if next timer <--- timer is stop, an=
d will never apply new setting
>>>>>>>>>> ** otherwise set led_set_brightness_nosleep
>>>>>>>>>>
>>>>>>>>>> To fix that, when we delete the timer, we should clear LED_BLI=
NK_SW.
>>>>>>>>>
>>>>>>>>> Can you run the tests on the affected stable kernels? I have fe=
eling
>>>>>>>>> that the problem described might not be present there.
>>>>>>>>
>>>>>>>> Hm, I don't seem to have HW to test that out. Maybe someone else=
 does?
>>>>>>>
>>>>>>> Why are you submitting patches you have no way to test?
>>>>>>
>>>>>> What?  This is stable tree backporting, why are you trying to make=
 a
>>>>>> requirement for something that we have never had before?
>>>>>
>>>>> I don't think random patches should be sent to stable just because
>>>>> they appeared in mainline. Plus, I don't think I'm making new rules=
:
>>>>>
>>>>> submit-checklist.rst:
>>>>>
>>>>> 13) Has been build- and runtime tested with and without ``CONFIG_SM=
P``
>>>>> and
>>>>>    ``CONFIG_PREEMPT.``
>>>>>
>>>>> stable-kernel-rules.rst:
>>>>>
>>>>> Rules on what kind of patches are accepted, and which ones are not,=

>>>>> into the "-stable" tree:
>>>>>
>>>>> - It must be obviously correct and tested.
>>>>> - It must fix a real bug that bothers people (not a, "This could be=
 a
>>>>>   problem..." type thing).
>>>>
>>>> So you're saying that this doesn't qualify as a bug?
>>>>
>>>>>> This is a backport of a patch that is already upstream.  If it doe=
sn't
>>>>>> belong in a stable tree, great, let us know that, saying why it is=
 so.
>>>>>
>>>>> See jacek.anaszewski@gmail.com 's explanation.
>>>>
>>>> I might be missing something, but Jacek suggested I pull another pat=
ch
>>>> before this one?
>>>
>>> Just to clarify:
>>>
>>> For 4.14 below patches are chosen correctly:
>>>
>>> [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness setting wh=
en
>>> setting delay_off=3D0
>>> [PATCH AUTOSEL for 4.14 094/110] leds: core: Fix regression caused by=

>>> commit 2b83ff96f51d
>>>
>>> For 4.9 both above patches are needed preceded by:
>>>
>>> eb1610b4c273 ("led: core: Fix blink_brightness setting race")
>>>
>>> The issue the patch [PATCH AUTOSEL for 4.14 065/110] fixes was
>>> introduced in 4.7, and thus it should be removed from the series
>>> for 3.18 and 4.4.
>>>
>>
>> It seems only "led: core: Fix brightness setting when setting delay_of=
f=3D0"
>> was applied to 4.9. Could we get the regression fixes backported to 4.=
9 as
>> well?
>=20
> What exact fixes were they?  I'll be glad to apply them if I have a git=

> commit id.
>=20
> thanks,
>=20
> greg k-h
>=20

At least 7b6af2c531 ("leds: core: Fix regression caused by commit
2b83ff96f51d") is missing, causing visible regressions (LEDs not working =
at
all) on some OpenWrt devices. This was fixed in 4.4.121 by reverting the
offending commit, but if I followed the discussion correctly, 4.9 should
get the follow-up commit 7b6af2c531 instead (like 4.14 already did).

Jacek's mail I replied to mentions that eb1610b4c273 ("led: core: Fix
blink_brightness setting race") should be included in 4.9 as well, but I
don't know the impact of the issue it fixes.

Matthias


--NkO56V4fbhZ7k7BjSwKNfWAU5FfuMElfM--

--2uNZMO2HuCPwY4vnEDfGaYBS3WS5Bapti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAlqmoKcACgkQFu8/ZMsg
HZyUVxAAxg1eBtxPjBKXOiVsIAhIood+uPkrr5CeXnOM8LkuwUndiYqfWHg5m8QR
Z5VbZiGVkZbLzdm7dmBMnmdnNCfhZEjnZGaHKQV6DlGzgm7d7BiwpKZl0FUZmvYP
vvWNxVBRsc3IODZ39kiQTUPk+qqz2VVKcbVwKj7gtNjP0EwIfdtzqxbZDWsFJ2Jb
ar1zWKjGfyXVT9Q5K3tbS2Z/kFaBs478dZhtVBGwRsQQtLkauK8lPSdEZ0Q9iivv
kp650/cfdMy+zC5YDW61CqWd7dAloUgCmABluO8OQ3aqanfzNms6Af+zBli9K9W4
zigMYUlBWr0dPdRlBZrvwc31ei9+oQtwA3cnhstVRkhA800JvpLd2PxMrwT6fi5b
tDosDncgLSZJ5qTDLyU17RHZ5XmVmZOck+iWHDHwgNH2p2Y2vCg7hIkMewy+JPRw
QBdiAbo0MefuIWEegD87qovPv/eZANK0lB+jOnPZwWbrQtAFTgPCxDTeaSnBgusm
0gtmAtFekZd3YrOSVJrIZYdRQi8ku7b2WGzAd5zo7DBFPxbzlmHFoMsv5ViRSHnC
Dz4cgv4Hck5sqnU2AtM11mdgvnTEZYMZYq/DEbWS7JAu7wmfYmzJM4VnN0s1YQf1
B4ACikxtKXElDMDKRYvZuQ7NVbJ58JEaE1K2mEoVzK+I+qiaZr4=
=bPJv
-----END PGP SIGNATURE-----

--2uNZMO2HuCPwY4vnEDfGaYBS3WS5Bapti--
