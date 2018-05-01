Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeEAIDq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:03:46 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:39285 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeEAIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:03:41 -0400
X-Google-Smtp-Source: AB8JxZqK+0pRwDiMnnQalag4/Ftqm2xgxuCpaj5l7gVrqNUj/Z1hvPTBtPKwB6IeaQBxVEkvAfKBiQ==
To: linux-kernel@vger.kernel.org
From: Tony Wallace <tony@tony.gen.nz>
Subject: Suggested new user link command
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
Message-ID: <decdbe00-2292-3012-d7ae-6bfa382fc74a@tony.gen.nz>
Date: Tue, 1 May 2018 20:03:35 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4183psw030544

I am suggesting a new command for linking files.  Currently there is no
easy way to link a file with a known inode number to its correct
position in the directory tree.  


int ilink(const int inode, const char *newpath)


The current alternative to this command is to find the file path
associated with an inode using the find command and then once found
using a standard link command.  Obviously this is very inefficient.  I
am certainly willing to give a patch a go, but I would like approval in
principle first.


Tony Wallace
