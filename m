Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF75C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C60D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 18:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BOaupYho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbeLYSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 13:18:12 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:33975 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeLYSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 13:18:12 -0500
Date:   Tue, 25 Dec 2018 18:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1545761887;
        bh=FJUXCA+4TsqlP9MKgp+GtljHMqYffh6e63TJ+ASDjQ0=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=BOaupYhoar7WNE3iqzcn8ljvEu//XPPEH7GwYvSJZicbgAWb4mO9McaRYzqDlLL+v
         cKSIQzKBRPpuqS/qjmBrH+DKaML7eY/j7cPgkKDo68wdYx5v97IX139f8lGrWSw46u
         0iO157NFWis8aCyqua0DCQkDng7xgFvmJZjs/nIM=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Re: Racoh Computer (Fair Pay OS) Year End Summary (slight update/correction)
Message-ID: <Y_Q4JA9HnLQH7N8_erx8n1gqa3UnaYv0FF-1xk_MPbYi5elxpW3jJfDD9aRuLXQQoC-GasidDbFMcOj8FW27yy_J5fRGcjDLfONgfqaiDzk=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Racoh Computer design year end summary:

I have been working with the philosophy behind Racoh Computer the last half=
 year and a bit more, an ultimate computer based on principles from my rese=
arch on monotheism that has been top 1% on academia.edu, and present a summ=
ary of it:

=09=09    Racoh Computer Design Specification

Delyar: absolute, global online currency, decentralized and free from infla=
tion.

FPY Licence: intended for use in a system, where fair pay transactions are =
done, for use, maintenance and support. Free for poor.

Islam: Coherent philosophy, replacing The Bible, as background in earlier O=
Ss (Unix), also with a z=C3=ABn-concept of The G=C3=B3dh, that works in our=
 culture, Yxxyn, that has decreed "deal justly", and is the background for =
its Fair Pay OS reasoning and labour party politics that are similar, and w=
ork union efforts, also using The Miriam Font, for script-like text accurac=
y.

Ultimate Iterations Of Tech:
=09[1.] Screenmode: 4K (8k quadratic WR-GB subpixels) at 72.734 hz
=09standard, for minimal psychovisual noise, approximating reality
=09most.
=09[2.] Sound Output: One Pole Diode Filter DA converter, for
 =09ultrahigh speed=09high-frequency 1-bit stream gibbsfree DA
=09conversion, for a nice -110dB =09noisefloor.
=09[3] O-S: Fair Pay oriented OS, with Low-jitter filesystem, with
=09file attributes about re-use or not, published or not, and
=09royalties, in a standardized directory structure,
=09country/15.000 km2 region/author, with typical statistics.
=09[4.] CPU: Instruction set, may combine several instructions in
=09one clock, where it makes sense, for higher virtual frequency,
=09and for closer to high-level paradigm thinking. For instance, a
=094pole filter (one input, one output), can be combined into a
=09one clock operation. JSR could take arguments. And
=09similary used functions, that has just one input, and one
=09output, can be done in one clock. And this could even be done
=09in parallel. (Particulary what needs ofcourse to be optimized
=09is the inner loop, beyond the HZ timer, which in our testing is
=09best at 90).
=09[5.]  Gaming Mode: Fast Fantasymode (Reduced Rendering Surface)
=09For Games Gaming Mode: 1920x1080 rendering with 2x
=09multisampling antialiasing only,transparency multisampling also
=09on) for smoothing the edges just a bit, more gets blurry, and
=092x anistotropic filtering, for round edges on zoomed textures
=09and "game profile", and also -0.1250 lod bias, for "game
=09profile". Negative lod bias allowed, high quality filtering,
=09and no trilinear optimization. Upscaled 3x by NN, and followed
=09by a median filter, for extrapolating a pseudo 3x res, and
=09resampled to 4K, with a bicubic (a=3D75) filter.

Beneficience: We also ofcourse fully support 3d-printed clothing, houses an=
d tools, taking centralized efforts and technology, to decentralized growth=
 places.

Technocracy: Supporting the development of a technocracy, where a L=C3=
=A9ad manages specialists seleted by their workgroup. This is much how inte=
rnet works already, and  part of information reduction to a managable level=
, with a standard monotheistic language.

Peace.
Ywe C=C3=A6rlyn.

Youtube version: https://www.youtube.com/watch?v=3DyeXNB-fjgs4
