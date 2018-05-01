Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755695AbeEAMR1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:17:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34944 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbeEAMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:17:23 -0400
X-Google-Smtp-Source: AB8JxZrzMKMdWjKZ1j+gaKT54XZBUy7KI1/TW9zo1Fjm6+fy+qizmJHj/bFZzbxPu0OpS3hMlZeGgQ==
Subject: Re: Suggested new user link command
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        LKML <linux-kernel@vger.kernel.org>
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
 <1525165387.23227.44.camel@petrovitsch.priv.at>
 <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
 <CAFLxGvxpe78WhrEKcKRt5XRBMtT-mZUe9Bm=sQsn8-f1TnX0eQ@mail.gmail.com>
From: Tony Wallace <tony@tony.gen.nz>
Openpgp: preference=signencrypt
Autocrypt: addr=tony@tony.gen.nz; prefer-encrypt=mutual; keydata=
 xsBNBFJQ2EUBCADNvUoh5QwEOCnkYCEMwg8zJzp8chmFePT2wqVmWAQXVPPKOWsHyGxYmoDe
 Guqpvmhx4rPpjW9CpX1xN7m6JPGE7FDCpw6WiOjAuNycSUFbKrVaSGpzMHjVx3eJpwOtEGTz
 DbHmGz32to1D2SwuITmXpVzXLAR4+A9ywSozaZc42UeLf/9jh77SR3mKEJpMxiqD6Ui+XGTV
 3zJRPTdh0s8z4lAhgqRM+he8bRpURydaTgGaEUDKDSHL/3bBx+q0QTcnWpGJRDjyqhlO87eu
 EXtZZbgBwg5+N+OGhZ5pzs82g6tKyHTLUsHsO2fPjXz1SFoxBlhQQRpHg25F4YgfNEOFABEB
 AAHNKEFudGhvbnkgSmFtZXMgV2FsbGFjZSA8dG9ueUB0b255Lmdlbi5uej7CwHgEEwECACIF
 AlJQ2EUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEDrpo/TJux46690H/AvCKeQ3
 pSWRWptbEsbWT9xPfmk9eD8LsYIIV/mHu/QhpekHeiSYv59lP3pLcOv7BYhe4oe4rte5Xc5z
 mllQBTFhFtIqNpv8UDWWmPGmS58nXm9fQaEJGoJ6XVYX9OWcD6B70x1U1DJFj8YJpaoUZLcJ
 rfbyUfqYVNjmRq3x8prdXZohTki9lHrcqMpyz30MYjV4cCGz/rj9cQpBDlfPIxG10zbyPSvD
 gclJJ9hGW9FHq3h8oH4kJR4jHUa0o2xy9ZdLQnAl196kB3yonHgFPexb4HPvwRxL23qtSxkY
 B7p7IJTf0xbk9UOPWD7EhY0ASiFgSw7uv/VwYceVe3PXkCvOwE0EUlDYRQEIAMNv3KI6lMO9
 Z3UyPwrEwzBWCqKkcVJwCh3UUgHQKSxeYdL8PhFnaQD0kr0J0R1sLKooS+OExu5rmvy3qoQ3
 BA2f13OUZF2ZotW3woVSGStSniEzs6l7L+mWtBQwyIjSyMPa4tuxKIWgy1b2S1axk0yTgn9w
 45ycTLiuT0H9FoNAZahRpU9gvH2gwJkZFoaW+5iibpzceFxUX7bfutdcw2FhV0dh1lkvGcdO
 QnaoWZcislZ5hFFfy07SDtGBqu46C0hRZKwZ1lj/H4/uJwQXmD6ywEusJDnqjFqellYJHmoP
 9s7q3POwWvxr5pXquLb/GlWvmEWFSwyozuypqRsLhzEAEQEAAcLAXwQYAQIACQUCUlDYRQIb
 DAAKCRA66aP0ybseOoHNCACZ/mwhUt3jxzDAroX+3YosiQRh8cFFHOk6RUpt4eLjrk12DVHY
 CuNIHf16jyMQybkOeBvyeWxvNpXzapdjMWK7Zp0eVQEAeKj9J/PQzZFHpYy0z0L2OQjKR2q8
 ciXRMm8ytF/mJZZbYICyyL5Yq4gz8Gs+mXROUmYDvadt9NxMLJH4kynF11FEnIPTq0xBuBuf
 Q/GAAlKxvc4anYWduDuvHUKcTnRssj6TW5ThxFyoBpuF/h0qDyfcUrE5y+WUcGjYyHu9j6oW
 UBsT9zlpxkqRNxO38tAnl601FBLtJClYygBz9Ro6DQAIcQX1Wqvcv3jLszOzH2hiu1Yg2Ipz 0Sdc
Message-ID: <388f79ad-4ed0-ec39-f649-5c120ee9dc2f@tony.gen.nz>
Date: Wed, 2 May 2018 00:17:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxpe78WhrEKcKRt5XRBMtT-mZUe9Bm=sQsn8-f1TnX0eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41CHhFN023832

Two issues here:
1) Use case (which I have)
2) Permissions

1) Use case

I am trying to build a backup system.  To avoid duplication of files
over multiple backups I take an Md5 check sum of file contents.  Files
with the same sum are hardlinked together.   Files are linked in to a
standard directory structure a new link for each backup that the file is
part of.  When all backups pointing to a file are deleted the reference
count drops to zero and the file is deleted.  We can keep a database of
checksums and there related inode numbers for linking purposes.  So why
not have some reference copy to link against it would take no extra
space.  Well it doesn't, but it keeps at least one copy of the file on
disk forever and the reference count never drops to zero.  Using one of
the backup copies to link to (as stored as the reference copy in the
database) will not work as it could be deleted at any time.

I have seen on stack overflow others wanting to do this also.

2) Permissions

To maintain security there are two requirements: 
2.1) The effective user must have rights to the inode, that is they must
either own it or be root
2.2) The effective user must have rights file creation rights to the
directory where it is being linked

If you say no, that is fine, but I do think this idea has merit and can
be done without compromising the system.

I am off to bed, it is the middle of the night here in New Zealand.



Tony


On 01/05/18 23:04, Richard Weinberger wrote:
> On Tue, May 1, 2018 at 12:58 PM, Tony Wallace <tony@tony.gen.nz> wrote:
>> Good point.  But there are gid and uid fields in inode disc record.
>>
>> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Inode_Table
>>
>> I assume these can be use to ensure that the directory in which it is to
>> be placed has permissions to accept the inode.  If that is not the case
>> then it would have to be a root only syscall.
> Before we dig into details, please come up with a very good use case. :-)
> But I'm with Bernd, I don't think it is worth the permissions hassle.
>
