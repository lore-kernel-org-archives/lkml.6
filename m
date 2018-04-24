Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756969AbeDXKDt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:03:49 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:41251 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756844AbeDXKDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:03:48 -0400
X-Google-Smtp-Source: AIpwx4/aIQqiSGPNxFpmHanpD3JHUFw3vRleyBpbWA2UYkD3KYEHAxjSUap43P2evu/auXZR1VnrrA==
Subject: Re: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board
 definition to common dtsi
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
 <20180424095656.oormsyru7nw6hypn@flea>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <20d4b1f5-b300-37e2-8dca-e80f691440a9@baylibre.com>
Date: Tue, 24 Apr 2018 12:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424095656.oormsyru7nw6hypn@flea>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BhxkOqONeiJQZN16oYmah9nRi37QkatJ1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BhxkOqONeiJQZN16oYmah9nRi37QkatJ1
Content-Type: multipart/mixed; boundary="L89TSL1B51Dl4L5vmxRxrSAksBiE9Cknr";
 protected-headers="v1"
From: Neil Armstrong <narmstrong@baylibre.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, clabbe@baylibre.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-ID: <20d4b1f5-b300-37e2-8dca-e80f691440a9@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board
 definition to common dtsi
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
 <20180424095656.oormsyru7nw6hypn@flea>
In-Reply-To: <20180424095656.oormsyru7nw6hypn@flea>

--L89TSL1B51Dl4L5vmxRxrSAksBiE9Cknr
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/04/2018 11:56, Maxime Ripard wrote:
> Hi,
>=20
> On Tue, Apr 24, 2018 at 11:19:35AM +0200, Neil Armstrong wrote:
>> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move t=
he
>> content of the dts file to a common dtsi file to be included by the H3=
 variant
>> and in a following patch the H5 variant.
>>
>> By the way, update the SPDX licence tag position.
>>
>> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>=20
> This patch looks fine, but doesn't apply anymore. Please resend it.

I based it on 4.17-rc2, should I rebase in your tree ?

>=20
> While you're at it, the prefix should be "arm: dts: sun8i: h3:" (with
> arm being lowercase).

Good to know,

>=20
> Thanks!
> Maxime
>=20

Thanks,
Neil



--L89TSL1B51Dl4L5vmxRxrSAksBiE9Cknr--

--BhxkOqONeiJQZN16oYmah9nRi37QkatJ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa3wEAAAoJEHfc29rIyEnReLgQAIEomWpqOBGHzXQ6v7PJN5N+
ujD79dmnrOuMI5nl58zEctvskr7dI1fn1fx6NFUgdsZGE0NTwdduG5/h6JqlBtnH
PDEPQhurm7Chv7uEPBrdsygE0nou3c4+WHx8PBiB4xnjZD1N5urlkMuTZL6rNrXV
GT+rQMNKbsESyYEd3HF9VK2QpeAm9BNXwnevkzYgcK2JXHO2rJnaRrdBD6Tw91Lq
FSa3Mto/GWl+fAz0I+X4ouz3w8c1gwJKcB4/VbxTnRl0WMdi1h3/aYYCk/w9i0FO
l33V5q8S//Lff3X/DvsJtPktQM2fIcke+MsjAMnvi6xC2KyhlrrhH1SQd/80IUdB
DnkPYkQTDCrsgR20hiHRL50xuwrWOpvgJyHq06LtOI+y4HrG5sHvEnueOmqv8AmE
PTqyBm9+txTp0FKFWqYVCp6nmJWljpQZoczIH3WTCD3Zc4lfXpeGPdbRegt1/l5d
VFutICBiWwuX9Wdsre/hhvgyLMgElm2M56a+H2DC6kY9HN14OkldQ/rLS8gxwXVR
3MCHvZc1x2DOmVKeMXWyN5fRJH43mXYaQ3Yb9QFduJLSrJ23HUB4pQaIKYGMLmi0
5qW+IIYSw7lMBxXDVL0Bdy6+Ywsnl5TlAqEt2FjsJaCTbtryOGdlpQbNeNQwBIIG
D/1a7+BQJJ2OCaZB2Fui
=zgE+
-----END PGP SIGNATURE-----

--BhxkOqONeiJQZN16oYmah9nRi37QkatJ1--
