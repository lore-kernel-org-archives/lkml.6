Return-Path: <outreachy-kernel+bncBAABBL464PKAKGQE7KGBUFY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1519963952; cv=pass;
        d=google.com; s=arc-20160816;
        b=HlsD6RfMExrxfo+KC6FX1+g81dLoxmhYxsRV+NXKquRkjP8WOhZenPbUBkTHtCASl4
         2wJy4yznA1nf5wKU3zMdH3PGXlpvRsSErwNlmNWuS5JpBo6DGyWqQ+5hqQAv3hzBfdfv
         AtVx0NG3e33SnOZ7R8Sb8gC1qqCO58NEERXCyZjBus9kLj66I9OxjOYq2GAgNXvvNRDV
         /D5gRzzPHX3KQK7uKQyF2s9pmPAZDVL4+fyoSWSWvxtYgKU6b7QqF4iPsZj6ip2qyrS6
         H9k4lUSBceMrbd2iR03dt1n5pE4cTZHIZmVD/YGTxPH0ORoM4IrL/tfSuPbtfkU7PTcV
         BuiQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:organization
         :from:references:cc:to:subject:reply-to:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=075oZUzBfNGqVu+BO4OZh5Esz1Z+cZeFel4SfOO8yPs=;
        b=Z2RGKCb0Ty8aZIYNqr4fF/YvqoR6T+dY8h7pscit/StOkNBo45S6znb6/pUv3Bzdd1
         DK84+SE15lhwDVuxyK2SK+6Wklk8JslwkwOnjI8T9x+TCfWgF9UKfIoEu9emfrI1uHC3
         JDNgMHIAvi55yfSLiTE6XFxlrRk67clu0W+iYmKGZM8zqlMj7JxuEC5p1ydYIBKRVlNA
         Y8q2qNxDAtQHsDKqp1zQUHGr0HKxqGRu+kMP7ZVXx00kEOs/7gRmDHwzb0bv7xa8yY+r
         N+QXHx+ZkNtG39ljCZby2LoJvANPxHRDtj9Yx8jZ+FblfC4c+iZM/o4xCKkLwRfLkOm/
         Pm0g==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ACKqRtTT;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbaabbl464pkakgqe7kgbufy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBAABBL464PKAKGQE7KGBUFY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=ACKqRtTT;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbaabbl464pkakgqe7kgbufy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBAABBL464PKAKGQE7KGBUFY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1519963952; cv=pass;
        d=google.com; s=arc-20160816;
        b=vaxCzcSZ2K53gvXqYVIbkI+QGzlpcKr16a6FG8IZNmqVBDVXPK8kUImsriDEUe2zqC
         oa1eDmQrlo2aRVdakEiviK3sHFztMWeTnMw+apYlJz65MOq91yGxi0wCZp2ccUXcwoW3
         gKUTjpGz9BVz5vF+rw+Vkz/c2tV1eSkZriKHkXQm30bJVx8SWyA47BGfgZzuYbTaBz61
         pUeNRvpvdRdp3tnqH6J41Jyr78Kz38InTLWBUIWvTvWe1WpUfaVyptnTvbwW4h5VFX/k
         fB0GyIHu+LSbPPQ+2jbEzztX5QVq0xwrxGk4G0kHDiWCetAWONf7O4ffy6BKsnkVzVw7
         Nc8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:organization
         :from:references:cc:to:subject:reply-to:arc-authentication-results
         :arc-message-signature:sender:dkim-signature
         :arc-authentication-results;
        bh=075oZUzBfNGqVu+BO4OZh5Esz1Z+cZeFel4SfOO8yPs=;
        b=iA2ZhKpVn2j29p3dqiTZH7HxhZCVyWGFhwYajW4PdyUm0GE4fyGlaBTwcO/puAGpGe
         3U1PI2i3sJpT4nW6SHzau2ckDUO80HXbz4ofTJe5Lcl6SXb1Bdx/kUWDvuAeHzug9Cu3
         dbqrYJHq+Des8PmoUXFoeiglybXXnlQk67waXxioZyVWK0iLtWyWntI3U+ufGbDJhvw+
         IsIwILOhmPVFTxXMBC1D5KZPlB7pyiwUotpZN8fQAer62qoE9DbBN4bLaQi5RQRLM2BI
         exQBgA+Uwp1APhL7rfZLXq/9li3ilUdsLVny0qRaErBfMitI8QaEbGL6a/LKODWK0byj
         K2Ww==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 152.77.200.57 is neither permitted nor denied by domain of nicolas.palix@imag.fr) smtp.mailfrom=Nicolas.Palix@imag.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtQguNQMQ5xVveM/Z/peDkaFvjTTjnk9hQrC9BqSB2LRJo8/lvQv4lm00UFkkWc0D9EhdSNMQ==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1519933560; cv=none;
        d=google.com; s=arc-20160816;
        b=optkjBemoGFBQJTziDzRd2KWzSch5ku79EGvhJD3KfT1ZZVgUwdfM7vX0BcA8alIU7
         z9sMg/l6fNmRYMN2YXSUWHBBZ8dnZF4+mle/tMpo1m9Ir7hIpoDuXWifSRwaADyU4647
         Kbbez9ycBipLCxRXCU4WKvu5nxQdq6CyTixUJCotmMEh9ByWBg/0YS+ArpbjVyPWEAcb
         vcRRKy62Mj/vww3as8dFvPjmqAjNQf2IsI2BRUG7qyY5nUaMfw55dorKn9lRIequx6Es
         JyArfz5WGsInI2hlFmEdFWnQF9GLtocykvlnYxQ/8W0Gzb/os3mI09dtZwIhi/W2xFOv
         zO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:arc-authentication-results;
        bh=W5nQd1cIELLM+mf8yvPQo9s9DGhckW3wGvNXV8U+NOs=;
        b=K2Qv+vFJTE3i7bbKMwESeQPymQVvJlJsWdR98nZwy32MPGHWGHGggFwT2Nph8DtZ2W
         +4bsyhFWKEPHqRafIAcU0cmyB9jxYzPowwWDdKozJuVJxjmU0/dSy0ROYeVG/xf77FD6
         ScWueIBbYvB5gXLBbXfaUZ7cFpEHfWqBUaTj/PtpkMEExDhxER0RDsh7eOnrHZrWig0M
         VsDVREc1hFnVI+m1p6836UkKGJQmfDW67W3pVCquF0ZWLpA8FdX3CaDlEePU8puS0Nxo
         d661dMxLUfRhUZz5D6XD4gG7i5qDR7ThJrE+1tI3gnQabFg82/4JYeV9lROm5hRf3Og2
         7uiw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 152.77.200.57 is neither permitted nor denied by domain of nicolas.palix@imag.fr) smtp.mailfrom=Nicolas.Palix@imag.fr
Reply-To: nicolas.palix@univ-grenoble-alpes.fr
Subject: [Outreachy kernel] Re: [PATCH] Coccinelle: memdup: Fix typo in
 warning messages
To: Dafna Hirschfeld <dafna3@gmail.com>, Julia.Lawall@lip6.fr,
 Gilles.Muller@lip6.fr, michal.lkml@markovi.net,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
References: <20180301085717.GA4508@gmail.com>
From: "Nicolas Palix (LIG)" <Nicolas.Palix@imag.fr>
Organization: UJF Polytech / LIG Erods
Message-ID: <8cc75580-b29a-a599-4af1-6bb3783bc705@imag.fr>
Date: Thu, 1 Mar 2018 20:45:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301085717.GA4508@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: nicolas.palix@imag.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 152.77.200.57 is neither permitted nor denied by domain of
 nicolas.palix@imag.fr) smtp.mailfrom=Nicolas.Palix@imag.fr
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593725048662035735?=
X-GMAIL-MSGID: =?utf-8?q?1593797722088611094?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Le 01/03/2018 =C3=A0 09:57, Dafna Hirschfeld a =C3=A9crit=C2=A0:
> Replace 'kmemdep' with 'kmemdup' in warning messages.
>=20
> Signed-off-by: Dafna Hirschfeld <dafna3@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>   scripts/coccinelle/api/memdup.cocci | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api=
/memdup.cocci
> index 1249b72..8fd6437 100644
> --- a/scripts/coccinelle/api/memdup.cocci
> +++ b/scripts/coccinelle/api/memdup.cocci
> @@ -56,10 +56,10 @@ statement S;
>   p << r.p;
>   @@
>  =20
> -coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdep")
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kmemdup")
>  =20
>   @script:python depends on report@
>   p << r.p;
>   @@
>  =20
> -coccilib.report.print_report(p[0], "WARNING opportunity for kmemdep")
> +coccilib.report.print_report(p[0], "WARNING opportunity for kmemdup")
>=20


--=20
Nicolas Palix
http://lig-membres.imag.fr/palix/

--=20
You received this message because you are subscribed to the Google Groups "=
outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
outreachy-kernel/8cc75580-b29a-a599-4af1-6bb3783bc705%40imag.fr.
For more options, visit https://groups.google.com/d/optout.
