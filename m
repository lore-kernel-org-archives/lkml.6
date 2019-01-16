Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A106C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37D320675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="sYVuK5U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfAPRas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:30:48 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:28457 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfAPRap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:30:45 -0500
Date:   Wed, 16 Jan 2019 17:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1547659841;
        bh=B8PwXFHrXpxS1HMplZ5Uyo714EdlJQTmrW71KCP9gvM=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=sYVuK5U30AwzdjDLS4N3dv9ThLGQ9vS+3XQk7zMAAM1Ag90VJOOuq9PJELc3ihRNK
         sixQijh4FkuntClDyj4YdBPxHPlSW6QMkA3bF7Y31mZrcEIkmr9f5dX/dxiLAlaVkx
         Am8wj7uP1eT5sKvqybz0FABlBGVeMYUiJXAaVT9M=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Reply-To: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywecrn@protonmail.com>
Subject: Racoh Computer design suggestion (+ theoretical prototype names).
Message-ID: <c4W6iZLaN8B1yMY9QkxUJ26klFoN54cNeHBjcwUEkzt1-zJf1vWCIiSFEhmuqBsKKNhbWsW9RwuBO0O9mZ0gDwQNxWBGconBt9ZLGGJRABw=@protonmail.com>
Feedback-ID: jE8CP55NmWCGfbi9g5qzrOGkxuwuSXpchSI6fmYzjd5UEveHXeJrmiWc0_sgJdqIHM8YAKf9EEyPwffaRmhZ0A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(v1.1)

I have been working with the philosophy behind Racoh Computer the last half=
 year and a bit more, an ultimate computer based on principles from my rese=
arch on monotheism that has been top 1% on academia.edu, and present a summ=
ary of it:

=09=09    Racoh Computer Design Specification

We see a problem with moving forward philosophy wise aswell as technical wi=
se.

And trends towards a convergence, where monotheistic principles and optimal=
 design and sales are the same, as a solution, and suggest the following, i=
n a standardized mass small size home computer: Racoh. Where emphasis is on=
 digital goods creation. Featuring:

Delyar: absolute, global online currency, decentralized and free from infla=
tion.

FPY Licence: intended for use in a system, where fair pay transactions are =
done, for use, maintenance and support. Free for poor.

Islam: Coherent philosophy, replacing The Bible, as background in earlier O=
Ss (Unix), also with a z=C3=ABn-concept of The G=C3=B3dh, for ease in our c=
ulture, =C3=9Cxx=C3=BCw, that has decreed "deal justly", and is the backgro=
und for labour party politics and work union efforts that are similar, also=
 using The Couring New Font, inspired by script-like text accuracy.

Screenmode: 4K (8k quadratic WR-GB subpixels) at 72.734 hz standard, for mi=
nimal psychovisual noise, approximating reality most. With graphics acceler=
ators accelerating the neccesary of this as standard, "XNU" being a theoret=
ical prototype name of this.

Sound Output: One Pole Diode Filter DA converter, for ultrahigh speed high-=
frequency 1-bit stream gibbsfree DA conversion, for a nice -110dB noisefloo=
r. "SN=C3=9C" being a theoretical prototype name of this.

O-S: =C3=9Cxx=C3=BCw For Ept O-S, a Fair Pay Available Source oriented OS, =
with Low-jitter filesystem, with file attributes about re-use or not, publi=
shed or not with automatic uploads to serverspace, and royalties, in a stan=
dardized directory structure, index/country/15.000 km2 region/author, with =
typical statistics, and commentary system.

CPU: Instruction set, may combine several instructions in one clock, where =
it makes sense, for higher virtual frequency, and for closer to high-level =
paradigm thinking. For instance, a 4pole filter (one input, one output), ca=
n be combined into a one clock operation. JSR could take arguments. And sim=
ilary used functions, that has just one input, and one output, can be done =
in one clock. We have called the theoretical CPU protoype the Gxu processor=
. And this could even be done in parallel. (Particulary what needs ofcourse=
 to be optimized is the inner loop, beyond the HZ timer, which in our testi=
ng is best at 90).

Gaming Mode: Fast Fantasymode (Reduced Rendering Surface) For Games Gaming =
Mode: 1920x1080 rendering with 2x multisampling antialiasing only,transpare=
ncy multisampling also on) for smoothing the edges just a bit, more gets bl=
urry, and 2x anistotropic filtering, for round edges on zoomed textures and=
 "game profile", and also -0.1250 lod bias, for "game profile". Negative lo=
d bias allowed, high quality filtering, and no trilinear optimization. Upsc=
aled 3x by NN, and followed by a median filter, for extrapolating a pseudo =
3x res, and resampled to 4K,  with a bicubic (a=3D75) filter.

Suggested approximate price per unit: 700$

Beneficience: We also ofcourse fully support 3d-printed clothing, houses an=
d tools, taking centralized efforts and technology, to decentralized growth=
 places.

Technocracy: Supporting the development of a technocracy, where a L=C3=
=A9ad manages specialists seleted by their workgroup. This is much how inte=
rnet works already, and  part of information reduction to a managable level=
, with a standard monotheistic language.

Peace.
Ywe C=C3=A6rlyn.
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q

