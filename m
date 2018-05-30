Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeE3Q0C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:26:02 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34788 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeE3Q0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:26:00 -0400
X-Google-Smtp-Source: ADUXVKIshXnHfKNQ6KXcvVfDe3YdQPlgKtJefO601j+TqaxX6TkJef4C0Fs4x/Q7nXuTRmPOnWyN27wEPTHhHxQpZvc=
MIME-Version: 1.0
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Wed, 30 May 2018 18:25:59 +0200
Message-ID: <CAFGhKbzv9mTOv-cttiyDLNSx8Sc-QiHCVfrAtsa+PcGGOW2Wog@mail.gmail.com>
Subject: checkpatch.pl: Perl regression in "improve patch recognition"
To: Joe Perches <joe@perches.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 9dd0c31c6cc0 ("checkpatch: improve patch
recognition"), the checkpatch.pl in linux-next is only printing a lot
of error messages when started (with and without arguments):

Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6496.
Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6516.
Variable "$cnt_error" is not imported at ./scripts/checkpatch.pl line 6518.
Variable "$cnt_warn" is not imported at ./scripts/checkpatch.pl line 6518.
Variable "$cnt_chk" is not imported at ./scripts/checkpatch.pl line 6519.
Variable "$cnt_lines" is not imported at ./scripts/checkpatch.pl line 6520.
Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6525.
Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6544.
Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6585.
Variable "$clean" is not imported at ./scripts/checkpatch.pl line 6591.
syntax error at ./scripts/checkpatch.pl line 2382, near ") {"
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2420.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2425.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2459.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2491.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2492.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2493.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2730.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2731.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2733.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2744.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2745.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2754.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2760.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2782.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2802.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2808.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2808.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2809.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2820.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2821.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2822.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2823.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2824.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2888.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2889.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2923.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2951.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2953.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
2966.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3015.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3026.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3049.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3050.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3051.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3061.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3061.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3062.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3074.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3080.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3087.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3149.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3159.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3160.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3166.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3167.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3168.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3169.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3177.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3189.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3225.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3232.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3248.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3250.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3252.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3254.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3256.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3258.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3260.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3262.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3264.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3277.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3278.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3296.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3302.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3309.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3322.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3331.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3347.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3675.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3690.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3782.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3803.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3805.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3808.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3975.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3976.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 3977.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3981.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
3982.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4001.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4004.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4168.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 4639.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 4692.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4817.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4823.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4843.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4845.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
4908.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 5257.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 5258.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5270.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5274.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5297.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5299.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5304.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5309.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5319.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5330.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5331.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5337.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5362.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5384.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 5384.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 5813.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
5814.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
6082.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 6263.
Global symbol "$sline" requires explicit package name (did you forget
to declare "my $sline"?) at ./scripts/checkpatch.pl line 6270.
Global symbol "$rawline" requires explicit package name (did you
forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line
6471.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6496.
Global symbol "$is_patch" requires explicit package name (did you
forget to declare "my $is_patch"?) at ./scripts/checkpatch.pl line
6496.
Global symbol "$is_patch" requires explicit package name (did you
forget to declare "my $is_patch"?) at ./scripts/checkpatch.pl line
6502.
Global symbol "$is_patch" requires explicit package name (did you
forget to declare "my $is_patch"?) at ./scripts/checkpatch.pl line
6506.
Global symbol "$filename" requires explicit package name (did you
forget to declare "my $filename"?) at ./scripts/checkpatch.pl line
6506.
Global symbol "$is_patch" requires explicit package name (did you
forget to declare "my $is_patch"?) at ./scripts/checkpatch.pl line
6510.
Global symbol "$has_commit_log" requires explicit package name (did
you forget to declare "my $has_commit_log"?) at
./scripts/checkpatch.pl line 6510.
Global symbol "$signoff" requires explicit package name (did you
forget to declare "my $signoff"?) at ./scripts/checkpatch.pl line
6510.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6516.
Global symbol "$filename" requires explicit package name (did you
forget to declare "my $filename"?) at ./scripts/checkpatch.pl line
6517.
Global symbol "$cnt_error" requires explicit package name (did you
forget to declare "my $cnt_error"?) at ./scripts/checkpatch.pl line
6518.
Global symbol "$cnt_warn" requires explicit package name (did you
forget to declare "my $cnt_warn"?) at ./scripts/checkpatch.pl line
6518.
Global symbol "$cnt_chk" requires explicit package name (did you
forget to declare "my $cnt_chk"?) at ./scripts/checkpatch.pl line
6519.
Global symbol "$cnt_lines" requires explicit package name (did you
forget to declare "my $cnt_lines"?) at ./scripts/checkpatch.pl line
6520.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6525.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6544.
Global symbol "$filename" requires explicit package name (did you
forget to declare "my $filename"?) at ./scripts/checkpatch.pl line
6547.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6585.
Global symbol "$clean" requires explicit package name (did you forget
to declare "my $clean"?) at ./scripts/checkpatch.pl line 6591.
syntax error at ./scripts/checkpatch.pl line 6592, near "}"
./scripts/checkpatch.pl has too many errors.
