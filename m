Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeEAK6m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:58:42 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38645 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEAK6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:58:40 -0400
X-Google-Smtp-Source: AB8JxZqZhZEiiIMyvIu7aG0zIGUGzkuWoEs8ds0vk4xsHtei6ero/A2HVJyu0U5vEypdw1ML9t6xIg==
Subject: Re: Suggested new user link command
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        linux-kernel@vger.kernel.org
References: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
 <1525165387.23227.44.camel@petrovitsch.priv.at>
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
Message-ID: <a91ef2fb-09ed-51ae-5dfa-8f71ec81f20c@tony.gen.nz>
Date: Tue, 1 May 2018 22:58:33 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525165387.23227.44.camel@petrovitsch.priv.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41Awlh7010739

Good point.  But there are gid and uid fields in inode disc record.

https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Inode_Table

I assume these can be use to ensure that the directory in which it is to
be placed has permissions to accept the inode.  If that is not the case
then it would have to be a root only syscall.


Tony


On 01/05/18 21:03, Bernd Petrovitsch wrote:
> Hi 
>
> On Tue, 2018-05-01 at 20:03 +1200, Tony Wallace wrote:
>> I am suggesting a new command for linking files.  Currently there is
>> no
>> easy way to link a file with a known inode number to its correct
>> position in the directory tree.  
>>
>>
>> int ilink(const int inode, const char *newpath)
> ... avoiding any permission checks on all paths to the existing names.
>
>> The current alternative to this command is to find the file path
>> associated with an inode using the find command and then once found
>> using a standard link command.  Obviously this is very inefficient.  
> That's the price for security as it requires proper permissions.
> Or is this a root-only syscall?
>
> MfG,
> 	Bernd
